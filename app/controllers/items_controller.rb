class ItemsController < ApplicationController

  def new
   @item = Item.new
  end

 def show
  @itens = Item.find_by(product: product, cart: cart)
  @itens.quantity
 end

  def more
    @product = Product.find(params[:product_id])
    cart = Cart.find(params[:cart_id])
    @item = Item.find_or_initialize_by(product: @product, cart: cart)
    @item.quantity += 1
    @item.save
  end

  def create
    @item = Item.new
    if @item.save
      redirect_to item_update_path
    else

    end
  end

  def less

    @product = Product.find(params[:product_id])
    cart = Cart.find(params[:cart_id])
    @item = Item.find_or_initialize_by(product: @product, cart: cart)
    @item.quantity -= 1
    if @item.quantity == 0
      @item.destroy
    else
      @item.save
    end

  end


  def destroy
    product = Product.find(params[:product_id])
    cart = Cart.find(params[:cart_id])
    item = Item.find_by(product: product, cart: cart)
    item.delete
    redirect_to cart_path


  end


  def items_params
    params.require(:item).permit(:product_id , :user_id)
  end
end
