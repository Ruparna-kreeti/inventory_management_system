class ItemsController < ApplicationController
  before_action :check_user_access, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  before_action :access_category_and_brand

  def index
    @items=Item.all
  end

  def show
    @item=Item.find(params[:id])
    @assigned_employees=EmployeesItem.where(item_id:@item.id)
  end

  def new
    @item=Item.new
  end

  def create
    @item=Item.new(item_params)
    @item.name=@item.name.downcase
    @item.file.attach(params[:item][:file])
    if @item.save
      redirect_to items_path, flash: { success: "Item added successfully" }
    else
      render 'new'
    end
  end

  def edit
    @item=Item.find(params[:id])
  end

  def update
    @item=Item.find(params[:id])
    if @item.update(item_params)
      redirect_to items_path, flash: { success: "Item updated successfully" }
    else
      render 'edit'
    end
  end

  def destroy
    if Item.find(params[:id]).employees.count < 1
      Item.find(params[:id]).destroy
      redirect_to items_path, flash: {success: "Item deleted successfully" }
    else
      redirect_to items_path, flash: { danger: "Item assigned to employee,cannot be deleted" }
    end
  end

  private
    def item_params
      params.require(:item).permit(:name.downcase,:brand_id,:category_id,:notes,:buffer_quantity,:file)
    end

    def access_category_and_brand
      @brands=Brand.all
      @categories=Category.all
    end

    def name_downcase
      self.name.downcase!
    end

    def check_user_access
      if !user_logged_in || !user_section.item
        redirect_to root_path, flash: { danger: "Not allowed to access" }
      end
    end
    
end