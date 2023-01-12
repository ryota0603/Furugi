class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_correct_customer,except: [:unsubscribe, :withdrawal]
  def show
    @customer = Customer.find(params[:id])
    @items = @customer.items
    @items = Item.all
  end
  def edit
    @customer = Customer.find(params[:id])
  end
 
  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:success] = "You have edited user data successfully."
      redirect_to customer_path(@customer)
    else
      render 'edit'
    end
    
  end
#退会確認画面の記述
  def unsubscribe
    @customer = current_customer
  end
#退会フラグを立てる記述
  def withdrawal
     @customer = current_customer
       if @customer.update(is_deleted: true)
          sign_out current_customer 
       end
       redirect_to root_path
  end
  
  private

  def customer_params
   params.require(:customer).permit(:is_deleted, :email, :name, :introduction, :profile_image)
  end
  #ログインしているユーザーを判断する記述
  def ensure_correct_customer
    @customer = Customer.find(params[:id])
    unless @customer == current_customer
      redirect_to customer_path(current_customer)
    end
  end
end
