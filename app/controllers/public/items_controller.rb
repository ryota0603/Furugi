class Public::ItemsController < ApplicationController
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    @item.customer_id = current_customer.id
    
   if @item.save
     redirect_to items_path(@item), notice: "You have created book successfully."
   else 
     render 'new'
   end
   

  end
  
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
    @post_comments = PostComment.all
  end
  
  def edit 
    @item = Item.find(params[:id])
    
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
       flash[:notice] = "商品を変更しました"
       redirect_to item_path(@item.id)
    else
       render :edit
    end
  end
  
  
  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_path, notice: "successfully delete book!"
    
  end

  private
  
  def item_params
      params.require(:item).permit(:image, :name, :shopname, :body, :address)
  end

end
