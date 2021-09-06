class StoragesController < ApplicationController
  include ItemsHelper
  before_action :check_correct_user, only: [:index, :new, :create, :edit, :update, :destroy]
  before_action :access_items

  def index
    @storages=Storage.all
  end

  def new
    @storage=Storage.new()
  end

  def create
    @storage=Storage.new(storage_params)
    if @storage.save
      redirect_to storages_path;flash[:success]="Stacked Successfully"
    else
      render 'new'
    end
  end

  def edit
    @storage=Storage.find(params[:id])
  end

  def update 
    @storage=Storage.find(params[:id])
    if @storage.update(storage_params)
      redirect_to storages_path;flash[:success]="updated successfully"
    else
      render 'edit'
    end
  end

  def destroy
    Storage.find(params[:id]).destroy
    redirect_to storages_path;flash[:success]="deleted successfully"
  end

  private
    def storage_params
      params.require(:storage).permit(:item_id,:procurement_date,:quantity)
    end

    def check_correct_user
      if !user_logged_in || !user_section.storage
        redirect_to root_path;flash[:danger]="Not allowed to access"
      end
    end

end