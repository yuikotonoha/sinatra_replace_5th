class Comment < ApplicationRecord

  # commentは1人のユーザーに所属する
  belongs_to :user
  # # commentは1つの投稿に所属する
  # belongs_to :post

  # 画像アップロード機能
  mount_uploader :comment_image, CommentimageUploader

end
