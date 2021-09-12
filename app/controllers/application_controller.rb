class ApplicationController < ActionController::Base
  include UserSessionsHelper
  include EmployeeSessionsHelper
  include ApplicationHelper
  def index
  end
    
end
