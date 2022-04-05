class AddUserReference < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :reference_id, :string, index: true
  end
end
