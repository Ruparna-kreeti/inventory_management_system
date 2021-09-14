# frozen_string_literal: true

require 'test_helper'

class StoragesControllerTest < ActionController::TestCase
  def setup
    @user = users(:michael)
    @user.section = sections(:admin_section)
    @other_user = users(:archer)
    @other_user.section = sections(:no_access)
    @employee = employees(:ruchan)
    @other_employee = employees(:megumi)
    @storage = storages(:store)
  end

  test 'cannot access storages when not logged in' do
    get :index
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'new storage path should redirect to root path when not logged in' do
    get :new
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'edit storage path should redirect to root path when not logged in' do
    get :edit, params: { id: @storage.id }
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'cannot access storages when logged in as invalid user' do
    session[:user_id] = @other_user.id
    get :index
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'new storage path should redirect to root path when logged in as invalid user' do
    session[:user_id] = @other_user.id
    get :new
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'edit storage path should redirect to root path when logged in as invalid user' do
    session[:user_id] = @other_user.id
    get :edit, params: { id: @storage.id }
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'cannot access storage when logged in as employee' do
    session[:employee_id] = @employee.id
    get :index
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'new storage path should redirect to root path when logged in as employee' do
    session[:employee_id] = @employee.id
    get :new
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'edit storage path should redirect to root path when logged in as employee' do
    session[:employee_id] = @employee.id
    get :edit, params: { id: @storage.id }
    assert_not flash.empty?
    assert_redirected_to root_path
  end
end
