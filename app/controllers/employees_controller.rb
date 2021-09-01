class EmployeesController < ApplicationController

  def index
    @employees=Employee.all
  end

  def show
    @employee=Employee.find(params[:id])
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

end
