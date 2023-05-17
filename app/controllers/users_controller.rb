class UsersController < ActionController::Base
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.recent_three_posts
  end
end



