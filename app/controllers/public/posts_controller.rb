class Public::PostsController < ApplicationController
  
  def new
    @post = Post.new
  end
  
  def create

  end
  
  def index
    @posts = Post.all
  
  end
  
  def show
    @post = Post.find(params{:id})
    
  end
  
  def edit 
    @post = Post.find(params{:id})
    
  end
  
  def update
  end
  
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
  
    
  end

  private
    def post_params
      params.require(:post).permit(:image, :name, :shopname, :body)
    end

end
