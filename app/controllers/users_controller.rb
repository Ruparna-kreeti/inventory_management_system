class UsersController < ApplicationController
  def index
    @users=User.where(admin:false)
  end

  def show
    @user=User.find(params[:id])
  end

  def new 
    @user=User.new
  end

  def create
    @user=User.new(user_params)
    if @user.save 
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
    if @user.update(user_params)
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

end
