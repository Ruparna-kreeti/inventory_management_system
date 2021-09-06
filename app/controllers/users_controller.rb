class UsersController < ApplicationController
  before_action :check_admin, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  def index
    @users=User.where(admin:false)
  end

  def show
    @user=User.find(params[:id])
  end

  def new 
    @user=User.new
    @user.build_section
  end

  def create
    @user=User.new(user_params)
    @section=@user.build_section(section_params)
    if @user.save && @section.save
      redirect_to @user; flash[:success]="User created Successfully"
    else
      render 'new'
    end
  end

  def edit
    @user=User.find(params[:id])
  end
  
  def update
    @user=User.find(params[:id])
    @section=@user.section
    if @user.update(user_params) && @section.update(section_params)
      redirect_to @user; flash[:success]="User updated successfully"
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    redirect_to users_url;flash[:success]="User deleted successfully"
  end

  private
    def user_params
      params.require(:user).permit(:name,:email,:password)
    end

    def section_params
      params.require(:user).permit(:user_id,:employee,:brand,:category,:item,:storage,:issue)
    end

    def check_admin
      if !user_logged_in || !current_user.admin
        redirect_to root_path;flash[:danger]="Not allowed to access"
      end
    end

end
