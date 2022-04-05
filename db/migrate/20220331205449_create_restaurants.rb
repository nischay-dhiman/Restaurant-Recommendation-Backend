class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string :name, index: true
      t.text :address
      t.string :city, index: true
      t.string :state
      t.string :postal_code
      t.decimal :latitude
      t.decimal :longitude
      t.float :stars, index: true
      t.integer :review_count
      t.text :categories
      t.string :business_id, index: true

      t.timestamps
    end
  end
end
