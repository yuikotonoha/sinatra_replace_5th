class FollowsController < ApplicationController

  def touch
    already_follow = Follow.find_by(followed_user_id: cookies[:followed_user_id], following_user_id: current_user.id)
    if already_follow.nil?
      Follow.create(followed_user_id: cookies[:followed_user_id], following_user_id: current_user.id)
      flash[:info] = 'フォローしました'
      redirect_to user_path(cookies[:followed_user_id])
    else
      already_follow.delete
      flash[:danger] = 'フォロー解除しました'
      redirect_to user_path(cookies[:followed_user_id])
    end
  end

end
