# frozen_string_literal: true

# brands controller manages brands view
class BrandsController < ApplicationController
  before_action :check_brand_access, only: %i[index new create edit update destroy]

  def index
    @brands = Brand.all
  end

  def new
    @brand = Brand.new
  end

  def create
    @brand = Brand.new(brand_params)
    if @brand.save
      redirect_to brands_path, flash: { success: 'Brand added successfully' }
    else
      render 'new'
    end
  end

  def edit
    @brand = Brand.find(params[:id])
  end

  def update
    @brand = Brand.find(params[:id])
    if @brand.update(brand_params)
      redirect_to brands_path, flash: { success: 'Brand updated successfully' }
    else
      render 'edit'
    end
  end

  def destroy
    @brand = Brand.find(params[:id])
    if check_employee_association @brand
      @brand.destroy
      redirect_to brands_path, flash: { success: 'Brand deleted successfully' }
    else
      redirect_to brands_path, flash: { danger: 'Employee has an item related to this brand' }
    end
  end

  private

  def brand_params
    params.require(:brand).permit(:name)
  end

  def check_brand_access
    redirect_to root_path, flash: { danger: 'Not allowed to access' } if !user_logged_in || !user_section.brand
  end
end
