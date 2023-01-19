class Admin::ItemsController < ApplicationController
before_action :authenticate_admin!
  def index
    @items = Item.page(params[:page]).per(8)
    @customer = current_customer
    @post_comment = PostComment.all
  end
  
  def show
    @item = Item.find(params[:id])
    gon.item = @item # 追記
    @customer = current_customer
    @post_comment = PostComment.new
  end
  
  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to admin_items_path, notice: "successfully delete book!"
    
  end

  private
  
  def item_params
      params.require(:item).permit(:image, :name, :shopname, :body, :address)
  end
end
