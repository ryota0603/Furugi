class Public::PostCommentsController < ApplicationController
  
  def create
    @item = Item.find(params[:item_id])
    @post_comment = current_customer.post_comments.new(post_comment_params)
    @post_comment.item_id = @item.id
    @post_comment.save
  end

  def destroy
    @item = Item.find(params[:item_id])
    @post_comment = PostComment.find_by(id: params[:id], item_id: params[:item_id])
    @post_comment.destroy
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
