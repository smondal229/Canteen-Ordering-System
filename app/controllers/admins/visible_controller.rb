class Admins::VisibleController < ApplicationController
  before_action :authenticate_admin

  def employee_order_notification
    @employees = Employee.all
  end

  def chef_order_notification
    @chefs = Chef.all
  end
end
