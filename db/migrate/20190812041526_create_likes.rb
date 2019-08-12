class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      # ここから
      t.integer "post_id"
      t.integer "user_id"
      # ここまで
      t.timestamps
    end
  end
end
