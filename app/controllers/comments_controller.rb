class CommentsController < ApplicationController
  before_action :get_post, only: [:create, :edit, :update, :destroy]
  before_action :get_comment, except: [:create]

  def create
    @comment = @post.comments.new(comment_params)

    if @comment.save
      render '_comment', locals: {comment: @comment}, layout: false, status: :ok
    else
      render html: display_errors(@comment), status: :internal_server_error
    end
  end

  def edit
    render 'edit', layout: false
  end

  def update
    if @comment.update(comment_params)
      render '_comment', locals: {comment: @comment}, layout: false, status: :ok
    else
      render html: display_errors(@comment), status: :internal_server_error
    end
  end

  def destroy
    if @comment.destroy
      render html: "Comment successfully deleted".html_safe, status: :ok
    else
      render html: display_errors("Error occurred deleting comment"), status: :internal_server_error
    end
  end

  private

  def get_post
    @post = Post.find(params[:post_id])
  end

  def get_comment
    @comment ||= @post.comments.find(params[:id])
  end

  #Limit params that can be submitted for comment
  def comment_params
    params.require(:post_id)
    params.require(:comment).permit(:text)
  end
end