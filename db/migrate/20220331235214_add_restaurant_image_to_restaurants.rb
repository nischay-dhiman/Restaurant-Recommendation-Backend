class AddRestaurantImageToRestaurants < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :restaurant_image, :string
  end
end
