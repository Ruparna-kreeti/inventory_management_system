module ItemsHelper

  def access_items
    @items=Item.all
  end
  
end