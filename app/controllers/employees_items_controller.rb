# frozen_string_literal: true

# employee items controller manages the association view of item and employee
class EmployeesItemsController < ApplicationController
  include EmployeesHelper
  include ItemsHelper
  before_action :check_user_access, only: %i[new create destroy]
  before_action :access_employees, :access_items

  def new
    @employees_item = EmployeesItem.new
  end

  def create
    @employees_item = EmployeesItem.new(employees_item_params)
    if @employees_item.save
      admin_notifications @employees_item.item
      redirect_to items_path, flash: { success: 'Employee assigned successfully' }
    else
      render 'new'
    end
  end

  def destroy
    @employee_item = EmployeesItem.find(params[:id])
    @employee_item.item.storage.increment!(:quantity)
    EmployeesItem.find(params[:id]).destroy
    redirect_to items_path, flash: { success: 'Association deleted successfully' }
  end

  private

  def employees_item_params
    params.require(:employees_item).permit(:item_id, :employee_id, :status)
  end

  def check_user_access
    redirect_to root_path, flash: { danger: 'Not allowed to access' } if !user_logged_in || !user_section.item
  end
end
