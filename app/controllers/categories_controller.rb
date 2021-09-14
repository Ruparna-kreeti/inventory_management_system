# frozen_string_literal: true

# categories controller manages categories view
class CategoriesController < ApplicationController
  before_action :check_category_access, only: %i[index new create edit update destroy]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path, flash: { success: 'Category added successfully' }
    else
      render 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to categories_path, flash: { success: 'Category updated successfully' }
    else
      render 'edit'
    end
  end

  def destroy
    @category = Category.find(params[:id])
    if check_employee_association @category
      @category.destroy
      redirect_to categories_path, flash: { success: 'Category deleted successfully' }
    else
      redirect_to categories_path, flash: { danger: 'Employee has an item related to this category' }
    end
  end

  private

  def category_params
    params.require(:category).permit(:name)
  end

  def check_category_access
    redirect_to root_path, flash: { danger: 'Not allowed to access' } if !user_logged_in || !user_section.category
  end
end
