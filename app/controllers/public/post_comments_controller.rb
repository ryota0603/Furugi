class Public::PostCommentsController < ApplicationController

  # def index
  #   @item = Item.find(params[:item_id])
  #   @comment = PostComment.new
  # end

  def create
    @item = Item.find(params[:item_id])
    @comment = current_customer.post_comments.new(post_comment_params)
    @comment.item_id = @item.id
    @comment.save
  end

  def destroy
    @comment = PostComment.find_by(id: params[:id], item_id: params[:item_id])
    @comment.destroy
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
