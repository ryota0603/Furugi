class Public::MapsController < ApplicationController
  def index 
    @items = Item.all
    gon.items = @items# 追記
  end
end
