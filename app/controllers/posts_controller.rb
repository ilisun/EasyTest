class PostsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_post, only: [:show, :edit, :update, :destroy]

  authorize_resource

  def index
    if params[:tag]
      @posts = Post.tagged_with(params[:tag]).published.page(params[:page]).per(5)
    else
      @posts = Post.published.page(params[:page]).per(5)
    end
  end

  def my_posts
    @posts = Post.my(current_user).page(params[:page]).per(5)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.create(posts_params)
    if @post.save
      flash[:notice] = 'Your post successfully created.'
      redirect_to @post
    else
      render :new
    end
  end

  def update
    if @post.update(posts_params)
      flash[:notice] = 'Your post successfully fixed.'
      redirect_to @post
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    flash[:notice] = 'Your post is successfully deleted.'
    redirect_to posts_path
  end

  private

  def load_post
    @post = Post.find(params[:id])
  end

  def posts_params
    params.require(:post).permit(:title, :body, :tag_list, :publish, :created_at)
  end
end
