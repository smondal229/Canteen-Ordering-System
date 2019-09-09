class ChefsController < ApplicationController
  before_action :authenticate_chef, only: [:show, :edit, :update, :read_all_notifications]
  before_action :authenticate_admin, only: [:approve, :reject, :notification_visible]
  before_action :set_chef, only: [:approve, :reject, :notification_visible]
  
  def edit
    @chef = current_chef
  end

  def update
    @chef = current_chef
    if @chef.update(chef_params)
      redirect_to(chef_path(@chef), flash: { success: "Profile information added!" })
    else
      render "new"
    end
  end

  def show
    @chef = current_chef
  end

  def approve
    if @chef.update(approved: true)
      Notification.create(notifiable: @chef, content: "You are approved to access food store")
      
      redirect_back(fallback_location: admins_root_path, flash: { success: "Chef Access Approved" })
    else
      redirect_back(fallback_location: admins_root_path, flash: { danger: "Chef Access Not Approved" })
    end
  end

  def reject
    if @chef.update(approved: false)
      Notification.create(notifiable: @chef, content: "You have been rejected by the admin")

      redirect_back(fallback_location: admins_root_path, flash: { success: "Chef Access Rejected" })
    else
      redirect_back(fallback_location: admins_root_path, flash: { danger: "Something went wrong" })
    end
  end

  def notification_visible
    if @chef.update(order_notification_visible: params[:visible])
      redirect_back(fallback_location: admins_root_path, flash: { success: "Visible status changed" })
    end
  end

  private
    def chef_params
      params.require(:chef).permit(:name, :phone, :food_store_id)
    end

    def set_chef
      @chef = Chef.find(params[:id])
    end
end
