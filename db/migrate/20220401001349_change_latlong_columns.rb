class ChangeLatlongColumns < ActiveRecord::Migration[6.0]
  def change
    change_column :restaurants, :latitude, :float
    change_column :restaurants, :longitude, :float
  end
end
