class CreatePlatforms < ActiveRecord::Migration[6.1]
  def change
    create_table :platforms do |t|
      t.string :name
      t.string :logo_path

      t.timestamps
    end
  end
end
