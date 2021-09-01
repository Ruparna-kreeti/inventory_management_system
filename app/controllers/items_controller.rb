class ItemsController < ApplicationController
  before_action :access_category_and_brand
  def index
    @items=Item.all
  end

  def show
    @item=Item.find(params[:id])
  end

  def new
    @item=Item.new
  end

  def create
    @item=Item.new(item_params)
    @item.name=@item.name.downcase
    @item.file.attach(params[:item][:file])
    if @item.save
      redirect_to @item;flash[:success]="Item added successfully"
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
      redirect_to @item;flash[:success]="Item updated successfully"
    else
      render 'edit'
    end
  end

  def destroy
    Item.find(params[:id]).destroy
    redirect_to items_path;flash[:success]="Item destroyed successfully"
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
    
end