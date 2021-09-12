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
      redirect_to storages_path, flash: { success: "Stacked Successfully" }
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
      redirect_to storages_path, flash: { success: "Updated Successfully" }
    else
      render 'edit'
    end
  end

  def destroy
    @storage=Storage.find(params[:id])
    if @storage.item.employees.empty?
      @storage.destroy
      redirect_to storages_path, flash: { success: "Deleted Successfully" }
    else
      redirect_to storages_path, flash: {danger: "Employee has this item.Please delete the association first" }
    end
  end

  private
    def storage_params
      params.require(:storage).permit(:item_id,:procurement_date,:quantity)
    end

    def check_correct_user
      if !user_logged_in || !user_section.storage
        redirect_to root_path, flash: {danger: "Not Allowed To Access" }
      end
    end

end