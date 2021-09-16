# frozen_string_literal: true

# employee controller manages employee views
class EmployeesController < ApplicationController
  before_action :check_employee_access, only: %i[index new create edit update destroy]
  before_action :check_correct_show_access, only: [:show]
  before_action :check_correct_issue_access, only: [:view_issues]

  def index
    @employees = Employee.includes(:items).all
  end

  def view_issues
    @issues = Issue.where(employee_id: params[:employee_id]).includes(:item)
  end

  def show
    @employee = Employee.find(params[:id])
    @assigned_items = EmployeesItem.where(employee_id: @employee.id)
  end

  def new
    @employee = Employee.new
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      AccountMailer.with(user: @employee).new_user_email.deliver_now
      redirect_to employees_path, flash: { success: 'Employee created Successfully' }
    else
      render 'new'
    end
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def update
    @employee = Employee.find(params[:id])
    if @employee.update(employee_params)
      redirect_to employees_path, flash: { success: 'Employee Updated Successfully' }
    else
      render 'edit'
    end
  end

  def destroy
    @employee = Employee.find(params[:id])
    @employee.items&.each do |item|
      item.storage.increment!(:quantity)
    end
    @employee.destroy
    redirect_to employees_path, flash: { success: 'Employee deleted Successfully' }
  end

  private

  def employee_params
    params.require(:employee).permit(:name, :email, :status)
  end

  def check_employee_access
    redirect_to root_path, flash: { danger: 'Not allowed to access' } if !user_logged_in || !user_section.employee
  end

  def check_correct_show_access
    @employee = Employee.find(params[:id])
    return if employee_logged_in && @employee.id == current_employee.id

    redirect_to root_path, flash: { danger: 'Not allowed to access' }
  end

  def check_correct_issue_access
    @employee = Employee.find(params[:employee_id])
    return if (employee_logged_in && @employee.id == current_employee.id) || (user_logged_in && user_section.employee)

    redirect_to root_path, flash: { danger: 'Not allowed to access' }
  end
end
