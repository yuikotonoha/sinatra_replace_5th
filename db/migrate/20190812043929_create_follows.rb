class CreateFollows < ActiveRecord::Migration[5.2]
  def change
    create_table :follows do |t|
      # ここから
      t.integer "followed_user_id"
      t.integer "following_user_id"
      # ここまで
      t.timestamps
    end
  end
end
