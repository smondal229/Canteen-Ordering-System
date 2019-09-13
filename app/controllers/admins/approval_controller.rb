class Admins::ApprovalController < ApplicationController
  skip_before_action :set_notification_badge
  before_action :authenticate_admin

  def employee_approve
    @pending = Employee.pending_access
  end

  def chef_approve
    @pending = Chef.pending_access
  end
end
