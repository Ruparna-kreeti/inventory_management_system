# frozen_string_literal: true

require 'test_helper'

class EmployeeSessionsControllerTest < ActionController::TestCase
  def setup
    @employee = employees(:ruchan)
  end

  test 'employee should logout' do
    session[:employee_id] = @employee.id
    delete :destroy, params: { id: @employee.id }
    assert_nil session[:employee_id]
    assert_not flash.empty?
    assert_redirected_to root_path
  end
end
