class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.references :user, index: true
      t.references :post, index: true

      t.timestamps null: false
      t.index [:user_id, :post_id], unique: true # この行を追加
    end
  end
end
