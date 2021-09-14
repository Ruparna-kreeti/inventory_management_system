# frozen_string_literal: true

# Applications controller is the starting controller
class ApplicationController < ActionController::Base
  include UserSessionsHelper
  include EmployeeSessionsHelper
  include ApplicationHelper

  def index; end
end
