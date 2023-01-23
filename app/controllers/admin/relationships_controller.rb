class Admin::RelationshipsController < ApplicationController
  before_action :authenticate_admin!
  # フォロー一覧
  def followings
    customer = Customer.find(params[:customer_id])
    @customers = customer.followings
  end
  # フォロワー一覧
  def followers
    customer = Customer.find(params[:customer_id])
    @customers = customer.followers
  end

end

