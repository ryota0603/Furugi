class Admin::SearchesController < ApplicationController
  def search
      @method = params[:name]
      @key_word = params[:key_word]
      @customers = Customer.search_for(@key_word, @method)
  end
  def itemsearch
      @method = params[:method]
      @key_word = params[:key_word]
      @items = Item.search_for('',@key_word,@method)
  end

end
