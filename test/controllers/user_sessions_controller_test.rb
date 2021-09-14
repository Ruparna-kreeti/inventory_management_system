# frozen_string_literal: true

require 'test_helper'

class UserSessionsControllerTest < ActionController::TestCase
  def setup
    @user = users(:michael)
    @employee = employees(:ruchan)
  end

  test 'should get new' do
    get :new
    assert_response :success
  end

  test 'should logout' do
    session[:user_id] = @user.id
    delete :destroy, params: { id: @user.id }
    assert_nil session[:user_id]
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'should redirect to root when logged in user tries to login' do
    session[:user_id] = @user.id
    get :new
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'should redirect to root when logged in employee tries to login' do
    session[:employee_id] = @employee.id
    get :new
    assert_not flash.empty?
    assert_redirected_to root_path
  end
end
