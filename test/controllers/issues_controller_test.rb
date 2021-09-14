# frozen_string_literal: true

require 'test_helper'

class IssuesControllerTest < ActionController::TestCase
  def setup
    @user = users(:michael)
    @user.section = sections(:admin_section)
    @other_user = users(:archer)
    @other_user.section = sections(:no_access)
    @employee = employees(:ruchan)
    @other_employee = employees(:megumi)
    @issue = issues(:test_issue)
  end

  test 'cannot access issues when not logged in' do
    get :index
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'edit issue path should redirect to root path when not logged in' do
    get :edit, params: { id: @issue.id }
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'cannot access issues when logged in as invalid user' do
    session[:user_id] = @other_user.id
    get :index
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'cannot delete issues when not logged in' do
    assert_no_difference 'Issue.count' do
      delete :destroy, params: { id: @issue.id }
    end
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'edit issue path should redirect to root path when logged in as invalid user' do
    session[:user_id] = @other_user.id
    get :edit, params: { id: @issue.id }
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'cannot access issues when logged in as employee' do
    session[:employee_id] = @employee.id
    get :index
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'edit issue path should redirect to root path when logged in as employee' do
    session[:employee_id] = @employee.id
    get :edit, params: { id: @issue.id }
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'access all issues when logged in as valid user' do
    session[:user_id] = @user.id
    get :index
    assert flash.empty?
  end

  test 'valid user can delete issue' do
    session[:user_id] = @user.id
    delete :destroy, params: { id: @issue.id }
    assert_not flash.empty?
    assert_redirected_to issues_path
  end
end
