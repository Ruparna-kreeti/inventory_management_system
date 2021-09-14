# frozen_string_literal: true

require 'test_helper'

# rubocop:disable Metrics/ClassLength
class EmployeesControllerTest < ActionController::TestCase
  def setup
    @user = users(:michael)
    @user.section = sections(:admin_section)
    @other_user = users(:archer)
    @other_user.section = sections(:no_access)
    @employee = employees(:ruchan)
    @other_employee = employees(:megumi)
  end

  test 'cannot access employees when not logged in' do
    get :index
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'new employee path should redirect to root path when not logged in' do
    get :new
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'edit employee path should redirect to root path when not logged in' do
    get :edit, params: { id: @employee.id }
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'should redirect destroy when not logged in' do
    assert_no_difference 'Employee.count' do
      delete :destroy, params: { id: @employee.id }
    end
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'cannot access employees when logged in as invalid user' do
    session[:user_id] = @other_user.id
    get :index
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'new employee path should redirect to root path when logged in as invalid user' do
    session[:user_id] = @other_user.id
    get :new
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'edit employee path should redirect to root path when logged in as invalid user' do
    session[:user_id] = @other_user.id
    get :edit, params: { id: @employee.id }
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'invalid user cannot delete employee' do
    session[:user_id] = @user.id
    delete :destroy, params: { id: @employee.id }
    assert_not flash.empty?
    assert_redirected_to employees_path
  end

  test 'cannot access employees when logged in as employee' do
    session[:employee_id] = @employee.id
    get :index
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'new employee path should redirect to root path when logged in as employee' do
    session[:employee_id] = @employee.id
    get :new
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'edit employee path should redirect to root path when logged in as employee' do
    session[:employee_id] = @employee.id
    get :edit, params: { id: @employee.id }
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'valid user should access employees' do
    session[:user_id] = @user.id
    get :index
    assert flash.empty?
  end

  test 'valid user should get new employee path' do
    session[:user_id] = @user.id
    get :new
    assert flash.empty?
  end

  test 'valid user should get edit employee path' do
    session[:user_id] = @user.id
    get :edit, params: { id: @employee.id }
    assert flash.empty?
  end

  test 'valid user can delete employee' do
    session[:user_id] = @user.id
    delete :destroy, params: { id: @employee.id }
    assert_not flash.empty?
    assert_redirected_to employees_path
  end

  test 'employee should access his profile' do
    session[:employee_id] = @employee.id
    get :show, params: { id: @employee.id }
    assert flash.empty?
  end

  test 'employee should not access other profile' do
    session[:employee_id] = @employee.id
    get :show, params: { id: @other_employee.id }
    assert_not flash.empty?
    assert_redirected_to root_path
  end
end
# rubocop:enable Metrics/ClassLength
