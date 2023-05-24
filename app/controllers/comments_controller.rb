class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @post = Post.find(params[:post_id])
  end

  def create
    @comment = current_user.comments.new(comment_params)
    @comment.post_id = params[:post_id]

    if @comment.save
      redirect_to user_posts_path
    else
      render :create
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
