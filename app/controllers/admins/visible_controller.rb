class Admins::VisibleController < ApplicationController
  skip_before_action :set_notification_badge
  before_action :authenticate_admin

  def employee_order_notification
    @employees = Employee.all
  end

  def chef_order_notification
    @chefs = Chef.all
  end
end
