class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!
  def search
      @method = params[:name]
      @key_word = params[:key_word]
      @customers = Customer.search_for(@key_word, @method)
  end
  def itemsearch
      @method = params[:method]
      @content = params[:content]
      if @method == "key_word"
      @items = Item.search_for(@content,@method)
      end
  end

end
