class Public::MapsController < ApplicationController
  def index 
    @area = params[:content]
    if @area == ""
    @items = Item.all
    gon.items = @items# 追記
    address = Geocoder.search(@items[0].address)
    gon.lat = address.first.coordinates[0]
    gon.lag = address.first.coordinates[1]

    else 
    @items = Item.search_for(@area,"area")
    gon.items = @items# 追記
    address = Geocoder.search(@items[0].address)
    gon.lat = address.first.coordinates[0]
    gon.lag = address.first.coordinates[1]
    end
  end
end
