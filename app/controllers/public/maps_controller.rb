class Public::MapsController < ApplicationController
  def index 
    @area = params[:content]
      if @area == ""
      @items = Item.all
      gon.items = @items# 追記
      address = Geocoder.search(@items[0].address)
      gon.lat = 37.592850
      gon.lag = 139.273690
      gon.zoom = 5.4
  
      else 
        @items = Item.search_for(@area,"area")
        if @items.present?
          gon.items = @items# 追記
          address = Geocoder.search(@items[0].address)
          gon.lat = address.first.coordinates[0]
          gon.lag = address.first.coordinates[1]
        end
        if @area == "北海道"
           gon.zoom = 6.8
        elsif @area == "岩手"
        　gon.zoom = 7.8
        else
          gon.zoom = 9
        end
      end
    
  end
end
