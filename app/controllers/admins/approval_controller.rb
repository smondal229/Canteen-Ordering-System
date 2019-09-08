class Admins::ApprovalController < ApplicationController
  before_action :authenticate_admin
  
  def employee_approve
    @pending = Employee.where(approved: nil).where.not(company: nil)
  end

  def chef_approve
    @pending = Chef.where(approved: nil).where.not(food_store: nil)
  end
end
