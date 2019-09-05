module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_user
      logger.add_tags current_user.name   
    end

    private
      def find_user
        if !request.session[:employee_id].nil?
          @user = Employee.find(request.session[:employee_id]) 
        elsif !request.session[:chef_id].nil?
          @user ||= Chef.find(request.session[:chef_id])
        else
          reject_unauthorized_connection
        end
      end
  end
end
