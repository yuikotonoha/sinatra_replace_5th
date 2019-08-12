class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      # ここから
      t.string :comment_text
      t.integer :post_id
      t.integer :user_id
      t.string :comment_image
      t.string :score
      # ここまで
      t.timestamps
    end
  end
end
