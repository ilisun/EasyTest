class CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :load_post, except: [:show]
  before_action :load_comment, only: [:edit, :update, :destroy]

  authorize_resource

  def new
    @comment = Comment.new
  end

  def create
    @comment = @post.comments.create(comments_params)
    @comment.user = current_user
    if @comment.save
      flash[:notice] = 'Your comment successfully created.'
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  def update
    if @comment.ensure_can_change?
      @comment.update(comments_params)
      flash[:notice] = 'Your comment successfully fixed.'
    end
    redirect_to post_path(@post)
  end

  def destroy
    @comment.destroy if @comment.ensure_can_change?
    redirect_to post_path(@post)
  end

  private

  def load_post
    @post = Post.find(params[:post_id])
  end

  def load_comment
    @comment = Comment.find(params[:id])
  end

  def comments_params
    params.require(:comment).permit(:body)
  end
end
