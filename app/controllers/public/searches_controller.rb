class Public::SearchesController < ApplicationController
  def new
  end
  def search
    @area = params[:area]
    @key_word = params[:key_word]
    @items = Item.search_for(@area, @key_word)
  end
end
