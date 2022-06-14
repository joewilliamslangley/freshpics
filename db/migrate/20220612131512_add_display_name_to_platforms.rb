class AddDisplayNameToPlatforms < ActiveRecord::Migration[6.1]
  def change
    add_column :platforms, :display_name, :string
  end
end
