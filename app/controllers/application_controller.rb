class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      store_location #app/helpers/sessions_helper.rb からメソッド呼び出し （アクセスしようとしたURLを覚えておく）
      flash[:danger] = "ログインしてください"
      redirect_to login_url
    end
  end

end
