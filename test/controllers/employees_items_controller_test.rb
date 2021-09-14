# frozen_string_literal: true

require 'test_helper'

class EmployeesItemsControllerTest < ActionController::TestCase
  def setup
    @user = users(:michael)
    @user.section = sections(:admin_section)
    @other_user = users(:archer)
    @other_user.section = sections(:no_access)
    @employee = employees(:ruchan)
    @other_employee = employees(:megumi)
    @brand = brands(:test)
  end

  test 'cannot assign item to employee when not logged in' do
    get :new
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'cannot assign item to employee when logged in as employee' do
    session[:employee_id] = @employee.id
    get :new
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'cannot assign item to employee when logged in as invalid user' do
    session[:user_id] = @other_user.id
    get :new
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'can assign item to employee when logged in as valid user' do
    session[:user_id] = @user.id
    get :new
    assert flash.empty?
  end
end
