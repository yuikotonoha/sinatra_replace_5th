class LikesController < ApplicationController

  def touch
    already_good = Like.find_by(post_id: cookies[:post_id], user_id: current_user.id)
    if already_good.nil?
      Like.create(post_id: cookies[:post_id], user_id: current_user.id)
      flash[:info] = 'お気に入り登録しました'
      redirect_to post_path(cookies[:post_id])
    else
      already_good.delete
      redirect_to post_path(cookies[:post_id])
    end
  end

end
