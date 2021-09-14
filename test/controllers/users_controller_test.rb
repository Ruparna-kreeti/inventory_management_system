# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  def setup
    @user = users(:michael)
    @admin_section = sections(:admin_section)
    @user.section = @admin_section
    @other_user = users(:archer)
  end

  test 'users should redirect to root when not logged in' do
    get :index
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'new user path should redirect to root path when not logged in' do
    get :new
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'edit user path should redirect to root path when not logged in' do
    get :edit, params: { id: @user.id }
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'new user path should redirect to root path when not valid user' do
    session[:user_id] = @other_user.id
    get :new
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'edit user path should redirect to root path when not valid user' do
    session[:user_id] = @other_user.id
    get :edit, params: { id: @user.id }
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'users should redirect to root when not logged in as valid user' do
    session[:user_id] = @other_user.id
    get :index
    assert_not flash.empty?
    assert_redirected_to root_url
  end

  test 'valid user should access index users' do
    session[:user_id] = @user.id
    get :index
    assert flash.empty?
  end

  test 'valid user should get new user' do
    session[:user_id] = @user.id
    get :new
    assert flash.empty?
  end

  test 'valid user should get edit user' do
    session[:user_id] = @user.id
    get :edit, params: { id: @other_user.id }
    assert flash.empty?
  end

  test 'valid user can delete user' do
    session[:user_id] = @user.id
    delete :destroy, params: { id: @other_user.id }
    assert_not flash.empty?
    assert_redirected_to users_path
  end
end
