class Public::SearchesController < ApplicationController
  def search
    @items = []
    if params[:method].present?
      @method = params[:method]
      @content = params[:content]
      if @method == "area"
         @items = Item.search_for(@content,@method).page(params[:page]).per(8)
         render "public/maps/index"
      elsif @method == "key_word"
        @items = Item.search_for(@content,@method).page(params[:page]).per(8)
         render "public/items/searchitems"
      elsif @method == "tag" 
        @items = Tag.search_for(@content)
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
