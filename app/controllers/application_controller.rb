class ApplicationController < ActionController::Base
  protect_from_forgery
  
  include AdminsHelper
  include EmployeesHelper
  include ChefsHelper
  include CartHelper
  
  WillPaginate.per_page = 6

  protected
  
    def find_employee_or_chef(auth)
      user = Chef.find_by(email: auth.info.email) || Employee.find_by(email: auth.info.email)
    end
  
    def approved(user)
      return if user.approved
    
      redirect_back(fallback_location: root_path, flash: { danger: "Sorry! You are not approved" })
    end

    def logged_in?
      if current_chef || current_employee
        redirect_back(fallback_location: root_path, flash: { danger: "You are already logged in" })
      elsif current_admin
        redirect_back(fallback_location: admins_root_path, flash: { danger: "You are already logged in" })
      end
    end

end
