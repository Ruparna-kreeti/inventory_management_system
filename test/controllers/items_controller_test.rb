# frozen_string_literal: true

require 'test_helper'

class ItemsControllerTest < ActionController::TestCase
  def setup
    @user = users(:michael)
    @user.section = sections(:admin_section)
    @other_user = users(:archer)
    @other_user.section = sections(:no_access)
    @employee = employees(:ruchan)
    @other_employee = employees(:megumi)
    @item = items(:test_item)
    @item.brand = brands(:test)
    @item.category = categories(:test_category)
  end

  test 'cannot access items when not logged in' do
    get :index
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'new item path should redirect to root path when not logged in' do
    get :new
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'edit item path should redirect to root path when not logged in' do
    get :edit, params: { id: @item.id }
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'cannot access items when logged in as invalid user' do
    session[:user_id] = @other_user.id
    get :index
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'new items path should redirect to root path when logged in as invalid user' do
    session[:user_id] = @other_user.id
    get :new
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'edit item path should redirect to root path when logged in as invalid user' do
    session[:user_id] = @other_user.id
    get :edit, params: { id: @item.id }
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'cannot access items when logged in as employee' do
    session[:employee_id] = @employee.id
    get :index
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'new item path should redirect to root path when logged in as employee' do
    session[:employee_id] = @employee.id
    get :new
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'edit item path should redirect to root path when logged in as employee' do
    session[:employee_id] = @employee.id
    get :edit, params: { id: @item.id }
    assert_not flash.empty?
    assert_redirected_to root_path
  end

  test 'valid user should get new item path' do
    session[:user_id] = @user.id
    get :new
    assert flash.empty?
  end

  test 'valid user should get edit item path' do
    session[:user_id] = @user.id
    get :edit, params: { id: @item.id }
    assert flash.empty?
  end

  test 'valid user can delete item' do
    session[:user_id] = @user.id
    delete :destroy, params: { id: @item.id }
    assert_not flash.empty?
    assert_redirected_to items_path
  end
end
