class CreateUserPlatforms < ActiveRecord::Migration[6.1]
  def change
    create_table :user_platforms do |t|
      t.references :user, null: false, foreign_key: true
      t.references :platform, null: false, foreign_key: true

      t.timestamps
    end
  end
end
