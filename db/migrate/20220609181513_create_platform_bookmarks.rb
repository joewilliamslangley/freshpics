class CreatePlatformBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :platform_bookmarks do |t|
      t.references :movie, null: false, foreign_key: true
      t.references :platform, null: false, foreign_key: true
      t.integer :added
      t.integer :leaving
      t.string :link

      t.timestamps
    end
  end
end
