class AddFreshpicsHandleToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :freshpics_handle, :string
  end
end
