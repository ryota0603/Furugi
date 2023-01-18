class Public::SearchesController < ApplicationController
  def search
    @items = []
    if params[:method].present?
      @method = params[:method]
      @area = params[:area]
      @key_word = params[:key_word]
      @items = Item.search_for(@area, @key_word, @method)
      if @method == "area"
        render "public/maps/index"
      end
    end
  end
end
