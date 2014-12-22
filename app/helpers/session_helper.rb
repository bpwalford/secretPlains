module SessionHelper

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def ip_hash_builder()
    ip_hash = {}
    
    ip_hast
  end

end
