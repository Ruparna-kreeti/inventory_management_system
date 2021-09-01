class EmployeesItemsController < ApplicationController
  before_action :access_employees_and_items

  def new
    @employees_item=EmployeesItem.new() 
  end

  def create
    @employees_item=EmployeesItem.new(employees_item_params)
    if @employees_item.save
      redirect_to items_path;flash[:success]="Employee assigned successfully"
    else
      render 'new'
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

    def access_employees_and_items
      @items=Item.all
      @employees=Employee.all
    end
end