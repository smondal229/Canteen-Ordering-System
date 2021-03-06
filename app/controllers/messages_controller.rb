class MessagesController < ApplicationController
  before_action :set_user
  before_action :set_recipientable

  def index
    @message = Message.new(sendable: @user)
    @messages = Message.find_recipientable(@user).or(Message.find_sendable(@user)).order_desc
  end

  def create
    @message = Message.new(message_params)
    
    respond_to do |format|
      if @message.save
        recipient_channel = "#{@message.recipientable_type}#{@message.recipientable_id}:messages_channel"

        ActionCable.server.broadcast(recipient_channel, {
          message: ApplicationController.renderer.render(partial: "messages/message", locals: { message: @message })
        })
      end
      format.js
    end
  end

  private
  
    def message_params
      params.require(:message).permit(:sendable_id, :sendable_type, :recipientable_id, :recipientable_type, :body)
    end

    def set_user
      @sendable_type, @sendable_id = request.path.split("/")[1,2]
      @sendable_class = @sendable_type.to_s.classify

      if @sendable_class == "Employee"
        authenticate_employee
        return @user = current_employee if current_employee.approved
      elsif @sendable_class == "Chef"
        authenticate_chef
        return @user = current_chef if current_chef.approved
      end

      redirect_back(fallback_location: root_path, flash: { danger: "Sorry! You need approval first" })
    end

    def set_recipientable
      if @sendable_class == "Employee"
        @recipient_class = "Chef".classify.constantize
      elsif @sendable_class == "Chef"
        @recipient_class = "Employee".classify.constantize
      end

      @recipients = @recipient_class.only_approved
    end
end
