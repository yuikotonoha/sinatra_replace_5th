class UsersController < ApplicationController
  #ログインしてないユーザーはプロフィール編集ページにはアクセス不可
  # app/controllers/application_controller.rb からメソッド呼び出す
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]

  #間違って、他の人のプロフィール編集ページにアクセスできないようにする
  before_action :correct_user,   only: [:edit, :update]

  # beforeフィルターでdestroyアクションを管理者だけに限定する
  before_action :admin_user,     only: :destroy

  def index
    @users = User.paginate(page: params[:page], per_page: 3) #1ページに表示させるユーザーは3人までと指定
  end

  def show
    # 今見ているユーザーの投稿一覧を取得
    @posts = Post.where(user_id: params[:id])
    # 今見るユーザーの情報を取得
    @user = User.find_by(id: params[:id])
    # フォローしているかの判定
    @follow_check = Follow.find_by(followed_user_id: params[:id], following_user_id: current_user.id)

    #今見ているユーザーがフォローされた場合、comment_controllerにpost_idを渡すための処理
    cookies[:followed_user_id] = params[:id]

    # フォローしてる人、フォロワー情報、お気に入りしている投稿情報を取得
    followed_user_ids = Follow.where(following_user_id: params[:id]).pluck(:followed_user_id)
    @follow_list = User.find(followed_user_ids)

    following_user_ids = Follow.where(followed_user_id: params[:id]).pluck(:following_user_id)
    @follower_list = User.find(following_user_ids)

    like_post_ids = Like.where(user_id: params[:id]).pluck(:post_id)
    @like_list = Post.find(like_post_ids)

    # タイムライン（フォローしている人の投稿一覧）を取得
    timeline_post_ids = Follow.where(following_user_id: params[:id]).pluck(:followed_user_id)
    @post_list = Post.where(user_id: timeline_post_ids )

    # フォロー数と、フォロワー数、お気に入り投稿数をカウント
    @follow_count = Follow.where(following_user_id: params[:id]).count
    @follower_count = Follow.where(followed_user_id: params[:id]).count
    @like_count = Like.where(user_id: params[:id]).count
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "ユーザーを作成しました"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      # 更新に成功した場合を扱う。
      flash[:success] = "プロフィールを更新しました"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "ユーザーを削除しました"
    redirect_to users_url
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :email, :password,
                                 :password_confirmation, :image)
  end

  # beforeアクション


  # 正しいユーザーかどうか確認 =>アクセスしようとしているユーザーのIDと、今ログインしているユーザーのIDを比較している
  def correct_user
    @user = User.find(params[:id])

    #sessions_helper.rb からcurrent_user?(user)メソッドを呼び出す
    # current_user メソッドを呼び出して結果が「false」なら、root_urlにリダイレクトさせる
    redirect_to(root_url) unless current_user?(@user)
  end

  # 管理者かどうか確認
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

end