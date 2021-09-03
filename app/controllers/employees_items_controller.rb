class EmployeesItemsController < ApplicationController
  include EmployeesHelper
  include ItemsHelper
  before_action :access_employees, :access_items

  def new
    @employees_item=EmployeesItem.new() 
  end

  def create
    @employees_item=EmployeesItem.new(employees_item_params)
    @item=Item.find_by(id:@employees_item.item_id)
    if @item.storage && @item.storage.quantity > 0
      if @employees_item.save
        @item.storage.decrement!(:quantity)
        redirect_to items_path;flash[:success]="Employee assigned successfully"
      else
        render 'new'
      end
    else
      redirect_to items_path;flash[:danger]="Either item not present in storage section or more quantity need to be stacked in storage"
    end
  end

  def destroy
    EmployeesItem.find(params[:id]).destroy
    redirect_back(fallback_location: root_path);flash[:success]="Association deleted successfully"
  end

  private
    def employees_item_params
      params.require(:employees_item).permit(:item_id,:employee_id,:status)
    end

end