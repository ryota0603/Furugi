class Public::FavoritesController < ApplicationController
  before_action :authenticate_customer!
  def create
    @item = Item.find(params[:item_id])
    favorite = current_customer.favorites.new(item_id: @item.id)
    favorite.save
    
  end

  def destroy
    @item = Item.find(params[:item_id])
    favorite = current_customer.favorites.find_by(item_id: @item.id)
    favorite.destroy
    
  end
  # いいね一覧の記述
  def like
   @customer = current_customer
   favorites = Favorite.where(customer_id: @customer.id).pluck(:item_id)
   @items = Item.where(id: favorites)
  end
end

