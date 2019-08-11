class User < ApplicationRecord

  # 画像投稿
  mount_uploader :image, ImageUploader

end
