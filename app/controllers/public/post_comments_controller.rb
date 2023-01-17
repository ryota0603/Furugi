class Public::PostCommentsController < ApplicationController

  def create
    # @item = Item.find(params[:item_id])
     @item = Item.find(params[:item_id])
    # comment = current_customer.post_comment_comments.new(post_comment_params)
    comment = current_customer.post_comments.new(post_comment_params)
    # comment.item_id = @item.id
    comment.item_id = @item.id
    # # comment.save
    #p comment
    comment.save
    # @items= Item.find(params[:item_id])
    # @post_comment = PostComment.new
    # @post_comments = PostComment.all
    @post_comments = PostComment.all
    # render  "public/items/show"
    #render  "public/items/show"
    render_to item_path(@item.id)
  end
  
  def destroy
    @item = Item.find(params[:item_id])
    @post_comment = PostComment.find(params[:id])
    @post_comment.destroy
    @post_comment = PostComment.new
    @post_comments = PostComment.all
    render "public/items/show"
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
