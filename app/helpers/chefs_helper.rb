module ChefsHelper

  def current_chef
    @current_chef ||= Chef.find(session[:chef_id]) if session[:chef_id]  
  end

  def authenticate_chef
    return unless current_chef.nil?
    
    session[:return_to] = request.referer
    redirect_to(login_path, flash: { info: "You have to login first! "})
  end
  
  def chef_return_path
    return_path = session[:return_to] || chef_path(session[:chef_id])
  end

end
