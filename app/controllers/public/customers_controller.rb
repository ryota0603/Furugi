class Public::CustomersController < ApplicationController
  before_action :is_matching_login_customer, only: [:edit, :update]
before_action :correct_customer, only: [:edit, :update]
  def index
    @customers = Customer.all
    @book = Book.new
    @user = current_user
  end
  
  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
  end

  def edit
  
    @user = User.find(params[:id])
  end
  
  def update

    @user = User.find(params[:id])
    if @user.update(user_params)
    flash[:notice] = "You have updated user successfully."  
    redirect_to user_path(@user.id)
    else
     
      render :edit
    end
  end
  
  private

  def customer_params
    params.require(:customer).permit(:name, :profile_image,:introduction)
  end
  def is_matching_login_customer
    customer_id = params[:id].to_i
    login_customer_id = current_customer.id
    if(customer_id != login_customer_id)
      redirect_to customer_path(current_customer.id)
    end
  end
  def correct_customer
    @customer = Customer.find(params[:id])
    redirect_to customer_path(current_customer.id) unless @customer == current_customer
  end
end
