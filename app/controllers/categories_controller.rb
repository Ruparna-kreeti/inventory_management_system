class CategoriesController < ApplicationController

  def index
    @categories=Category.all
  end

  def create
    @category=Category.new(category_params)
    if @category.save
      redirect_to categories_path;flash[:success]="Category added successfully"
    else
      redirect_to categories_path;flash[:danger] = @category.errors.full_messages.to_sentence
    end
  end

  def edit
    @category=Category.find(params[:id])
  end

  def update
    @category=Category.find(params[:id])
    if @category.update(category_update_params)
      redirect_to categories_path;flash[:success]="Category updated successfully"
    else
      render 'edit'
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    redirect_to categories_path;flash[:success]="Category deleted successfully"
  end

  private 
    def category_params
      params.permit(:name)
    end

    def category_update_params
      params.require(:category).permit(:name)
    end

end