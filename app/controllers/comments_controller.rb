class CommentsController < ApplicationController
  before_action :get_post, only: [:create, :edit, :update, :destroy]
  before_action :get_comment, except: [:create]

  def create
    @comment = @post.comments.new(comment_params)

    if @comment.save
      render '_comment', locals: {comment: @comment}, layout: false
    else
      render text: "Error occurred during comment creation"
    end
  end

  def edit
    render 'edit', layout: false
  end

  def update
    if @comment.update(comment_params)
      render '_comment', locals: {comment: @comment}, layout: false
    else
      render text: "Error occurred during comment update"
    end
  end

  def destroy
    render text: "Error occurred during comment delete" unless @comment.destroy
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