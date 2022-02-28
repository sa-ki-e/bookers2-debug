class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
    redirect_to request.referer
  end

  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
    redirect_to request.referer
  end

  #フォロー一覧
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end

  #フォロワー一覧
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
end

  #フォローする
  # def create
  #   current_user.follow(params[:user_id])
  #   redirect_to request.referer
  # end

  # #フォロー外す
  # def destroy
  #   current_user.unfollow(params[:user_id])
  #   redirect_to request.referer
  # end




#   private

#   def relationships_params
#     params.require(:user).permit(:follower_id, :followed_id)
#   end


# end
