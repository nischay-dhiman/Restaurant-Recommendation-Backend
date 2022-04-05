class RemoveTimestampsFromRestaurants < ActiveRecord::Migration[6.0]
  def change
    remove_column :restaurants, :created_at
    remove_column :restaurants, :updated_at
  end
end
