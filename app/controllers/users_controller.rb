# frozen_string_literal: true

# users controller manages users related views
class UsersController < ApplicationController
  before_action :check_admin, only: %i[index show new create edit update destroy]

  def index
    @users = User.where(admin: false)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @user.build_section
  end

  def create
    @user = User.new(user_params)
    @user.password = 'password'
    @user.build_section(section_params)
    if @user.save # && @section.save
      AccountMailer.with(user: @user).new_user_email.deliver_now
      redirect_to @user, flash: { success: 'User created Successfully' }
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
    @user.section
  end

  def update
    @user = User.find(params[:id])
    @user.build_section(section_params)
    if @user.update(user_params) # && @section.update(section_params)
      redirect_to @user, flash: { success: 'User updated successfully' }
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_url, flash: { success: 'User deleted successfully' }
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def section_params
    params.require(:user).permit(:user_id, :employee, :brand, :category, :item, :storage, :issue)
  end

  def check_admin
    redirect_to root_path, flash: { danger: 'Not allowed to access' } if !user_logged_in || !current_user.admin
  end
end
