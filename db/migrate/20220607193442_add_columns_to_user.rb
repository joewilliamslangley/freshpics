class AddColumnsToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :netflix, :boolean, default: false
    add_column :users, :prime, :boolean, default: false
    add_column :users, :disney, :boolean, default: false
    add_column :users, :mubi, :boolean, default: false
    add_column :users, :now, :boolean, default: false
    add_column :users, :britbox, :boolean, default: false
    add_column :users, :apple, :boolean, default: false
  end
end
