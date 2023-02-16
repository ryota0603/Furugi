class Public::SearchesController < ApplicationController
  def search
    @items = []
    if params[:method].present?
      @method = params[:method]
      @content = params[:content].split(/[[:blank:]]+/) # 空白で分割
      if @method == "area"
        @items = [] 
          @content.each do |content|  # 分割したキーワードごとに検索
           next if content == "" 
           @items += Item.search_for(content,@method)
          end
        @items = Kaminari.paginate_array(@items).page(params[:page]).per(8)
         render "public/maps/index"
      elsif @method == "key_word"
         @items = [] 
          @content.each do |content|  # 分割したキーワードごとに検索
           next if content == "" 
           @items += Item.search_for(content,@method)
          end
          @items = Kaminari.paginate_array(@items).page(params[:page]).per(8)
         render "public/items/searchitems"
      elsif @method == "tag" 
        @items = [] 
          @content.each do |content|  # 分割したキーワードごとに検索
           next if content == "" 
           @items += Tag.search_for(content)
          end 
        @items = Kaminari.paginate_array(@items).page(params[:page]).per(10)
         render "public/items/searchitems"
      end
    end
  end
end
