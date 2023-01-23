class Admin::FavoritesController < ApplicationController
     # 管理者でログインしているのみ閲覧可にするメソッド
  before_action :authenticate_admin!
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
end
