class BrandsController < ApplicationController
  before_action:check_brand_access, only: [:index, :create, :edit, :update, :destroy]

  def index
    @brands=Brand.all
  end
  
  def create
    @brand=Brand.new(brand_params)
    if @brand.save
      redirect_to brands_path;flash[:success]="Brand added successfully"
    else
      redirect_to brands_path;flash[:danger] = @brand.errors.full_messages.to_sentence
    end
  end

  def edit
    @brand=Brand.find(params[:id])
  end

  def update
    @brand=Brand.find(params[:id])
    if @brand.update(brand_update_params)
      redirect_to brands_path;flash[:success]="Brand updated successfully"
    else
      render 'edit'
    end
  end

  def destroy
    Brand.find(params[:id]).destroy
    redirect_to brands_path;flash[:success]="Brand deleted successfully"
  end

  private 
    def brand_params
      params.permit(:name)
    end

    def brand_update_params
      params.require(:brand).permit(:name)
    end

    def check_brand_access
      if !user_logged_in || !user_section.brand
        redirect_to root_path;flash[:danger]="Not allowed to access"
      end
    end
end