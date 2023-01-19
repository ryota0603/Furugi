class Admin::SearchesController < ApplicationController
  def search
    @customers = []
    if params[:method].present?
      @method = params[:method]
      @key_word = params[:key_word]
      @customers = Customer.search_for(@key_word, @method)
      if @method == "key_word"
        render "admin/searches/index"
      end
    end
  end
  def index
    @customers = Customer.all
  end

end
