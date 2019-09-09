class Admins::ApprovalController < ApplicationController
  skip_before_action :set_notification_badge
  before_action :authenticate_admin

  def employee_approve
    @pending = Employee.where(approved: nil).where.not(company: nil)
  end

  def chef_approve
    @pending = Chef.where(approved: nil).where.not(food_store: nil)
  end
end
