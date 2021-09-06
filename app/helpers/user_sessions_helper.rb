module UserSessionsHelper

  def log_in_user user
    session[:user_id]=user.id
  end

  def current_user
    if session[:user_id]
      @current_user||=User.find(session[:user_id])
    end
  end

  def user_logged_in
    !current_user.nil?
  end

  def user_section
    @section||=current_user.section
  end

end
