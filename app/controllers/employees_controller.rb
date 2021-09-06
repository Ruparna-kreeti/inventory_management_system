class EmployeesController < ApplicationController
  before_action :check_employee_access, only: [:index,:new,:create,:edit,:update,:destroy]
  before_action :check_correct_show_access, only: [:show]
  before_action :check_correct_issue, only: [:view_issues]
  def index
    @employees=Employee.all
  end

  def view_issues
    @issues=Issue.where(employee_id:params[:employee_id])
  end

  def show
    @employee=Employee.find(params[:id])
    @assigned_items=EmployeesItem.where(employee_id:@employee.id)
  end

  def new
    @employee=Employee.new
  end

  def create
    @employee=Employee.new(employee_params)
    if @employee.save
      redirect_to @employee;flash[:success]="Employee Created successfully"
    else
      render 'new'
    end
  end

  def edit
    @employee=Employee.find(params[:id])
  end

  def update
    @employee=Employee.find(params[:id])
    if @employee.update(employee_params)
      redirect_to @employee;flash[:success]="Employee Updated Successfully"
    else
      render 'edit'
    end
  end

  def destroy
    Employee.find(params[:id]).destroy
    redirect_to employees_url;flash[:success]="Employee Deleted Successfully"
  end

  private
    def employee_params
      params.require(:employee).permit(:name,:email,:status)
    end

    def check_employee_access
      if !user_logged_in || !user_section.employee
        redirect_to root_url;flash[:danger]="Not allowed to access"
      end
    end

    def check_correct_show_access
      @employee=Employee.find(params[:id])
      unless (employee_logged_in && @employee.id == current_employee.id) || (user_logged_in && user_section.employee) 
        redirect_to root_url;flash[:danger]="Not allowed to access"
      end
    end

    def check_correct_issue
      @employee=Employee.find(params[:employee_id])
      if (!employee_logged_in || @employee.id!=current_employee.id) && (!user_logged_in || !user_section.employee)
        redirect_to root_url;flash[:danger]="Not allowed to access"
      end
    end
    
end
