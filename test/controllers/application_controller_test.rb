# frozen_string_literal: true

require 'test_helper'

class ApplicationControllerTest < ActionDispatch::IntegrationTest
  test 'should get root' do
    get root_path
    assert_response :success
  end
end
