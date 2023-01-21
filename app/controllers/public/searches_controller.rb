class Public::SearchesController < ApplicationController
  def search
    @items = []
    if params[:method].present?
      @method = params[:method]
      @area = params[:area]
      @key_word = params[:key_word]
      @items = Item.search_for(@area, @key_word, @method).page(params[:page]).per(8)
      if @method == "area"
        render "public/maps/index"
      else 
        render "public/items/searchitems"
        
      end
    end
  end
  def usersearch
    # フォローユーザー検索機能
    # @method = params[:name]
    # @key_word = params[:key_word]
    # @customers = Customer.search_for(@key_word, @method)
  end
  
end
