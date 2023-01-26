class Admin::CustomersController < ApplicationController
    # 管理者でログインしているのみ閲覧可にするメソッド
  before_action :authenticate_admin!
  
  def show
    @customer = Customer.find(params[:id])
    @items = @customer.items
  end
  def index
    @customers = Customer.page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customers_path
    else
      render :edit
    end
  end
  
  

  private

  def customer_params
    params.require(:customer).permit(:name, :email, :is_deleted)
  end

end
