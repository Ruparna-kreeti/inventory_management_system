class EmployeesItemsController < ApplicationController
  include EmployeesHelper
  include ItemsHelper
  before_action :check_user_access, only: [:new, :create, :destroy]
  before_action :access_employees, :access_items

  def new
    @employees_item=EmployeesItem.new() 
  end

  def create
    @admins=User.where(admin:true)
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
    if @item.storage
      if @item.buffer_quantity + @item.storage.quantity <= @item.buffer_quantity
        @admins.each do |admin|
          AdminNotification.create!(user:admin,storage:@item.storage,content:"check asap",priority:'high')
        end
      elsif @item.buffer_quantity + @item.storage.quantity < (2 * @item.buffer_quantity)
        @admins.each do |admin|
          AdminNotification.create!(user:admin,storage:@item.storage,content:"check at prior date",priority:'medium')
        end
      end
    end
  end

  def destroy
    @employee_item=EmployeesItem.find(params[:id])
    @employee_item.item.storage.increment!(:quantity)
    EmployeesItem.find(params[:id]).destroy
    redirect_back(fallback_location: root_path);flash[:success]="Association deleted successfully"
  end

  private
    def employees_item_params
      params.require(:employees_item).permit(:item_id,:employee_id,:status)
    end

    def check_user_access
      if !user_logged_in || !user_section.item
        redirect_to root_path;flash[:danger]="Not allowed to access"
      end
    end
    
end