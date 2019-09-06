class SessionsController < ApplicationController
  before_action :logged_in?, only: [:new, :create]

  def new
  end

  def create
    

    if params[:user].present?
      user = find_user_by_email(params[:user][:email]) if params[:user][:email].present?

      if user && user.authenticate(params[:user][:password])
        session[user.class.name.downcase.concat("_id").to_sym] = user.id

        find_path(user)
      else
        redirect_back(fallback_location: root_path, flash: { danger: "Login or password is wrong!"})
      end

    elsif request.env["omniauth.auth"].present?
      facebook_auth = request.env["omniauth.auth"]

      if facebook_auth.info.email.present?
        user = find_employee_or_chef(facebook_auth)

        if user.try(:update_from_omniauth, facebook_auth)
          session[user.class.name.downcase.concat("_id").to_sym] = user.id

          find_path(user)
        else
          redirect_back(fallback_location: root_path, flash: { danger: "Not Found! Sign up by email and password!"} )  
        end
      else
        redirect_back(fallback_location: root_path, flash: { danger: "Sign up first!"} )
      end

    end
    
  end

  def destroy
    session.clear
    redirect_to(root_path, flash: { info: "You are logged out now" })
  end

  private
    def find_user_by_email(email)
      user = Employee.find_by(email: email)||Chef.find_by(email: email)||Admin.find_by(email: email)
    end

    def find_path(user)
      if !user.nil?
        if user.class.name == "Employee"
          redirect_to(employee_return_path, flash: { success: "Logged in successfully" })
        elsif user.class.name == "Chef"
          redirect_to(chef_return_path, flash: { success: "Logged in successfully" })
        elsif user.class.name == "Admin"
          redirect_to(admin_return_path, flash: { success: "Logged in successfully" })
        end
      end      
    end

end
