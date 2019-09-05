module EmployeesHelper
  
  def login_employee(user)
    session[:employee_id] = user.id
  end

  def current_employee
    @current_employee ||= Employee.find(session[:employee_id]) if session[:employee_id]  
  end

  def authenticate_employee
    return unless current_employee.nil?

    redirect_to(login_path, flash: { info: "You have to login first! "})  
  end

  def employee_return_path
    return_path = session[:return_to] || employee_path(session[:employee_id])
  end

end
