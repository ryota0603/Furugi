class Public::ItemsController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer, only: [:edit,:update,:destroy]
  def new
    @item = Item.new
  end
  
  def create
    @item = Item.new(item_params)
    @item.customer_id = current_customer.id
    tag_list = params[:item][:tag_name].split(',')
   if @item.save
      @item.save_tags(tag_list)
     redirect_to items_path(@item)
   else 
     render 'new'
   end
   

  end
  
  def index
    @items = Item.page(params[:page]).per(16)
    @customer = current_customer
    @post_comment = PostComment.all
  end
  
  def show
    if customer_signed_in?
      @item = Item.find(params[:id])
      gon.item = @item # 追記
      @post_comment = PostComment.new
    else
       redirect_to new_customer_registration_path
    end
  end
  
  def edit 
    @item = Item.find(params[:id])
    
  end
  
  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
       redirect_to item_path(@item.id)
    else
       render :edit
    end
  end
  
  
  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_path
    
  end
  
  
  private
  
  def item_params
      params.require(:item).permit(:image, :name, :shopname, :body, :address)
  end
  # loginしているか判断する記述
  def ensure_correct_customer
    @customer = Customer.find(params[:id])
    unless @customer == current_customer
      redirect_to items_path
    end
  end

end
