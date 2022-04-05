class RestaurantSerializer
  include JSONAPI::Serializer
  attributes :business_id, :name, :address, :city, :state, :postal_code, :latitude, :longitude, :stars, :review_count, :categories

  attribute :restaurant_image do |restaurant|
    "https://6167-184-147-92-41.ngrok.io" + restaurant.restaurant_image_url
  end

  attribute :user_rating do |restaurant, params|
    user_review = restaurant.reviews.find_by(user: params[:current_user])
    if !user_review.nil?
      user_review.stars
    end
  end

  attribute :favorite do |restaurant, params|
    user_fav = restaurant.favorites.find_by(user: params[:current_user])
    !user_fav.nil?
  end
end
