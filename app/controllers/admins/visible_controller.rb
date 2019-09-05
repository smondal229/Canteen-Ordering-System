class Admins::VisibleController < ApplicationController
  def employee_order_notification
    @employees = Employee.all
  end

  def chef_order_notification
    @chefs = Chef.all
  end
end
