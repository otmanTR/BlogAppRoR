class CommentsController < ApplicationController
    

    def new
   @comment = Comment.new
   @post = Post.find(params[:id])
    end
  
    def create
        @comment = current_user.comments.new(comment_params)
        @comment.author = current_user
    
        if @comment.save
          
          redirect_to "/users/#{current_user.id}/posts", notice: 'Comment created successfully!'
        else
          notice: 'Comment could not be created.'
          render :new
        end
      end
private
      def comment_params
        params.require(:comment).permit(:text)
      end
  end
  