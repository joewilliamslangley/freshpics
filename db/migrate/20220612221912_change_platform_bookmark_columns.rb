class ChangePlatformBookmarkColumns < ActiveRecord::Migration[6.1]
  def change
    change_column :platform_bookmarks, :added, :bigint
    change_column :platform_bookmarks, :leaving, :bigint
  end
end
