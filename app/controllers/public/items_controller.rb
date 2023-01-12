class Public::ItemsController < ApplicationController
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    
    @item.save
    
    redirect_to items_path(@item), notice: "You have created book successfully."

  end
  
  def index
    @items = Item.page(params[:page]).per(8)
  
  end
  
  # def show
  #   @post = Post.find(params{:id})
    
  # end
  
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
      params.require(:item).permit(:image, :name, :shopname, :body)
  end

end
