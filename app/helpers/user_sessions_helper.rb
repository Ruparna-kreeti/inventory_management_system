# frozen_string_literal: true

# helper for user sessions method
module UserSessionsHelper
  def log_in_user(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_logged_in
    !current_user.nil?
  end

  def user_section
    @user_section ||= current_user.section
  end
end
