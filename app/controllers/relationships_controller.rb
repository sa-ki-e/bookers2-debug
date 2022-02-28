class RelationshipsController < ApplicationController
  before_action :set_user
  
  def create
    following = current_user.follow(@user)
    if following.save
      flash[:success] = "ユーザーをフォローしました"
      redirect_to users_path
    else
      flash.now[:alert] = "ユーザーのフォローに失敗しました"
      redirect_to @user
    end
  end

  def destroy
    if following = current_user.unfollow(@user)
      flash[:success] = "ユーザーのフォローを解除しました"
      redirect_to @user
    else
      flash.now[:alert] = "ユーザーのフォロー解除に失敗しました"
      redirect_to @user
    end
  end

  #フォロー一覧
  def followings
   user = User.find(params[:id])
   @users = user.followings
  end

  #フォロワー一覧
  def followers
    user = User.find(params[:id])
    @users = user.followers
  end


  private

  def set_user
    @user = User.find(params[:follow_id])
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
