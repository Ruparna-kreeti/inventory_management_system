class IssuesController < ApplicationController
  include ItemsHelper
  before_action :check_user_access, only: [:index,:edit,:update,:destroy]
  before_action :check_employee_access, only: [:new, :create]
  before_action:access_items

  def index
    @issues=Issue.all
  end

  def new
    @employee=Employee.find_by(id:params[:employee_id])
    @issue=@employee.issues.new
  end

  def create
    @employee=Employee.find_by(id:params[:employee_id])
    @issue=@employee.issues.new(issue_params)
    if @issue.save
      redirect_to employee_path(@employee);flash[:success]="Issue added successfully"
    else
      render 'new'
    end
  end

  def edit
    @issue=Issue.find(params[:id])
  end

  def update
    @issue=Issue.find(params[:id])
    if @issue.update(edit_issue_params)
      EmployeeNotification.create(employee:@issue.employee,issue:@issue,content:"Your issue is resolved for ")
      redirect_to issues_path;flash[:success]="Issue resolved"
    else
      render 'edit'
    end
  end

  def destroy
    @issue=Issue.find(params[:id])
    if @issue.is_solved
      @issue.destroy
      redirect_to issues_path;flash[:success]="Issue deleted"
    else
      redirect_to issues_path;flash[:danger]="please verify the issue before deleting"
    end
  end

  private
    def issue_params
      params.require(:issue).permit(:employee_id,:item_id,:detail,:is_solved)
    end

    def edit_issue_params
      params.require(:issue).permit(:is_solved)
    end

    def check_user_access
      if !user_logged_in || !user_section.issue
        redirect_to root_path;flash[:danger]="Not allowed to access"
      end
    end

    def check_employee_access
      @employee=Employee.find(params[:employee_id])
      if !employee_logged_in || @employee.id!=current_employee.id
        redirect_to root_path;flash[:danger]="Not allowed to accesss"
      end
    end

end