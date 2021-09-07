class UserSessionsController < ApplicationController
  before_action :check_no_logins, only: [:new, :create]
  before_action :check_correct_logout, only: [:destroy]

  def new
  end

  def create
    user=User.find_by_email(params[:email].downcase)
    if user && user.authenticate(params[:password])
      log_in_user user
      redirect_to root_path;flash[:success]="Logged in successfully"
    else
      flash.now[:danger]="Not authorized user"
      render 'new'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path;flash[:success]="Logged out successfully"
  end

  def googleAuth
    # Get access tokens from the google server
    access_token = request.env["omniauth.auth"]
    user = User.from_omniauth(access_token)
    if user.nil?
      flash.now[:danger]="Not authorized user"
      render 'new'
    else
      session[:user_id]=user.id
      # Access_token is used to authenticate request made from the rails application to the google server
      user.google_token = access_token.credentials.token
      # Refresh_token to request new access_token
      # Note: Refresh_token is only sent once during the first request
      refresh_token = access_token.credentials.refresh_token
      user.google_refresh_token = refresh_token if refresh_token.present?
      user.save
      redirect_to root_path;flash[:success]="Logged in successfully"
    end
  end

  private
    def check_no_logins
      if user_logged_in || employee_logged_in
        redirect_to root_path;flash[:danger]="you are already logged in"
      end
    end

    def check_correct_logout
      if !user_logged_in
        redirect_to root_path;flash[:danger]="you are not logged in as a main user"
      end
    end

end
