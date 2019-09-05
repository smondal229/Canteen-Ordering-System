module AdminsHelper

  def login_admin(user)
    session[:admin_id] = user.id
  end

  def current_admin
    @current_admin ||= Admin.find(session[:admin_id]) if !session[:admin_id].nil?
  end

  def authenticate_admin
    return unless current_admin.nil?

    session[:return_to] = request.referer
    redirect_to(login_path, flash: { danger: "You must login first!" })
  end

  def admin_return_path
    return_path = session[:return_to] || admins_root_path
  end

  def logout_admin
    session[:admin_id] = nil
  end

end
