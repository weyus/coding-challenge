#Notes:
# Not worrying about alternate rendering targets other than HTML

class PostsController < ApplicationController
  before_action :get_post, only: [:show, :destroy]
  before_action :get_text_size, only: [:index]

  def index
    search_params = params[:search]

    #Limit list if a search is requested
    if search_params.present? && (term = search_params[:term]).present?
      @posts = Post.where("lower(title) LIKE ? OR lower(body) LIKE ?", "%#{term.downcase}%", "%#{term.downcase}%")
    end

    #Default to showing all posts if no search is requested
    @posts ||= Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(new_post_params)

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

  #Limit params that can be submitted for post creation
  def new_post_params
    params.require(:post).permit(:title, :body)
  end

  def get_text_size
    @text_size = 100
  end
end