# frozen_string_literal: true

# employee sessions controller manages employee login
class EmployeeSessionsController < ApplicationController
  def destroy
    session.delete(:employee_id)
    redirect_to root_path, flash: { success: 'Logged out successfully' }
  end
end
