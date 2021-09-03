class SectionsController < ApplicationController
  def create
  end

  private

    def section_params
      params.require(:user).permit(:user_id,:employee,:brand,:category,:item,:storage,:issue)
    end
end