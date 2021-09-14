# frozen_string_literal: true

require 'test_helper'

class BrandsControllerTest < ActionController::TestCase
  def setup
    @user = users(:michael)
    @user.section = sections(:admin_section)
    @other_user = users(:archer)
    @other_user.section = sections(:no_access)
    @employee = employees(:ruchan)
    @other_employee = employees(:megumi)
    @brand = brands(:test)
  end

  test 'cannot access brands when not logged in' do
    get :index
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'new brand path should redirect to root path when not logged in' do
    get :new
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'edit brand path should redirect to root path when not logged in' do
    get :edit, params: { id: @brand.id }
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'cannot access brands when logged in as invalid user' do
    session[:user_id] = @other_user.id
    get :index
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'new brand path should redirect to root path when logged in as invalid user' do
    session[:user_id] = @other_user.id
    get :new
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'edit brand path should redirect to root path when logged in as invalid user' do
    session[:user_id] = @other_user.id
    get :edit, params: { id: @brand.id }
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'cannot access brands when logged in as employee' do
    session[:employee_id] = @employee.id
    get :index
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'new brand path should redirect to root path when logged in as employee' do
    session[:employee_id] = @employee.id
    get :new
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'edit brand path should redirect to root path when logged in as employee' do
    session[:employee_id] = @employee.id
    get :edit, params: { id: @brand.id }
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'valid user should access brands' do
    session[:user_id] = @user.id
    get :index
    assert flash.empty?
  end

  test 'valid user should get new brand path' do
    session[:user_id] = @user.id
    get :new
    assert flash.empty?
  end

  test 'valid user should get edit brand path' do
    session[:user_id] = @user.id
    get :edit, params: { id: @brand.id }
    assert flash.empty?
  end
end
