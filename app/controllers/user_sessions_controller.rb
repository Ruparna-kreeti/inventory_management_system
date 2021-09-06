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
