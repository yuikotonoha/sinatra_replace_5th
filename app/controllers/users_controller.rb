class UsersController < ApplicationController

  def index
    @users = User.all
  end

  # newアクション
  def new
    @user = User.new
  end

  def create
    User.create(user_params)
    # 投稿完了後、すぐに一覧表示画面へ遷移
    redirect_to :action => :index
  end

    private

    def user_params
      params.require(:user).permit(:image)
    end

end