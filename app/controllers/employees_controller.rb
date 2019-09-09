class EmployeesController < ApplicationController
  before_action :authenticate_employee, only: [:show, :edit, :update, :read_all_notifications]
  before_action :authenticate_admin, only: [:approve, :reject, :notification_visible]
  before_action :set_employee, only: [:approve, :reject, :notification_visible]

  def show
    @employee = current_employee
  end

  def edit
    @employee = current_employee
  end

  def update
    @employee = current_employee
    
    if @employee.company_id != params[:employee][:company_id]
      @employee.update(approved: nil)
    end

    if @employee.update(employee_params)
      redirect_to(employee_path(@employee), flash: { success: "Profile information added!" })
    else
      render "new"
    end
  end

  def approve
    if @employee.update(approved: true)
      Notification.create(notifiable: @employee, content: "You have been approved by the admin")

      redirect_back(fallback_location: admins_root_path, flash: { success: "Employee Access Approved" })
    else
      redirect_back(fallback_location: admins_root_path, flash: { danger: "Employee Access Not Approved" })
    end
  end

  def reject
    if @employee.update(approved: false)
      Notification.create(notifiable: @employee, content: "You have been rejected by the admin")

      redirect_back(fallback_location: admins_root_path, flash: { success: "Employee Access Rejected" })
    else
      redirect_back(fallback_location: admins_root_path, flash: { danger: "Something Went Wrong" })
    end
  end

  def notification_visible
    if @employee.update(order_notification_visible: params[:visible])
      redirect_back(fallback_location: admins_root_path, flash: { success: "Visible status changed" })
    end
  end

  private
    def employee_params
      params.require(:employee).permit(:name, :phone, :company_id)
    end

    def set_employee
      @employee = Employee.find(params[:id])
    end

end
