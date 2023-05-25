class CommentsController < ApplicationController
  def index
    @posts = Post.find(params[:post_id])
    @user = User.find(params[:user_id])
    @comments = Comment.find(params[:comment_id])

    respond_to do |format|
      format.html
      format.json { render json: @comments }
    end
  end

  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = params[:post_id]
    @post = Post.find(params[:post_id])

    if @comment.save
      respond_to do |format|
        format.html { redirect_to user_post_path(@post.author, @post), notice: 'Comment created' }
        format.json { render json: @comment, status: :created }
      end

    else
      respond_to do |format|
        format.html { render :new, alert: 'Comment not created!' }
        format.json { render json: @comment.errors, status: :unprocessable_entry }
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment

    puts 'Authorization successful'

    if @comment.destroy
      flash[:success] = 'Comment deleted successfully.'
    else
      flash[:danger] = 'Comment could not be deleted.'
    end

    redirect_to user_posts_path(@post.author, @post)
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
