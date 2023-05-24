class PostsController < ApplicationController
  def index
    @posts = Post.all
    @user = User.find(params[:user_id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0
    @post.author = current_user

    if @post.save

      redirect_to "/users/#{current_user.id}/posts", notice: 'Post created successfully!'
    else
      render :new, notice: 'Post could not be created.'
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(params[:user_id])
  end

def destroy
  @post = Post.find(params[:id])
  authorize! :destroy, @post

if @post.destroy
  flash[:success] = 'Post deleted successfully.'  
else
  flash[:danger] = 'Post could not be deleted.'
end
redirect_to user_posts_path(current_user)
end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
