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
  
  end
  
  def show
    @item = Item.find(params[:id])
    gon.item = @item # 追記
    
  end
  
  # def edit 
  #   @post = Post.find(params{:id})
    
  # end
  
  # def update
  # end
  
  
  # def destroy
  #   @post = Post.find(params[:id])
  #   @post.destroy
  
    
  # end

  private
  
  def item_params
      params.require(:item).permit(:image, :name, :shopname, :body, :address)
  end

end
