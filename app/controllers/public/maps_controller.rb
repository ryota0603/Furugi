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
        # 拡大度を都道府県別に設定
        if @area == "北海道"
          gon.zoom = 6.8
        elsif @area == "岩手" or @area == "福島" or @area == "長野" or @area == "新潟" or @area == "秋田"
          gon.zoom = 7.8
        elsif @area == "岐阜" or @area == "青森" or @area == "山形" or @area == "鹿児島" or @area == "熊本" or @area == "宮城" or @area == "三重" or @area == "石川"
          gon.zoom = 8.2
        elsif @area == "広島" or @area == "兵庫" or @area == "静岡" or @area == "岡山" or @area == "高知"
          gon.zoom = 8.8
        elsif @area == "島根" or @area == "栃木" or @area == "群馬" or @area == "大分" or @area == "山口" or @area == "茨城" or @area == "愛媛" or @area == "千葉" or @area == "福井" or @area == "長崎" or @area == "鳥取" or @area == "沖縄"
          gon.zoom = 9.0
        elsif @area == "愛知" or @area == "福岡" or @area == "和歌山" or @area == "京都" or @area == "山梨"
          gon.zoom = 9.2
        elsif @area == "富山" or @area == "徳島" or @area == "滋賀" or @area == "埼玉" or @area == "奈良"
          gon.zoom = 9.4
        elsif @area == "佐賀" or @area == "神奈川" or @area == "東京" or @area == "大阪" or @area == "香川"
          gon.zoom = 9.6
        else
          gon.zoom = 12.4
        end
      end
    
  end
end
