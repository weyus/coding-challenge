#Notes:
# Not worrying about alternate rendering targets other than HTML

class PostsController < ApplicationController
  before_action :get_post, only: [:show, :destroy]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def show
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  #Provide post for actions that need it
  def get_post
    @post ||= Post.find(params[:id])
  end

  #Limit params that can be submitted
  def post_params
    params.require(:post).permit(:title, :body)
  end
end
