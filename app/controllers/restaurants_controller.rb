class RestaurantsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_restaurant, only: [:rating, :favorite]
  respond_to :json

  def index
    if params[:only_fav] == "true"
      restaurants = Restaurant.joins(favorites: :user).where(favorites: {user: current_user }).distinct.page(params[:page]).per(params[:per])
    elsif params[:only_reviewed] == "true"
        restaurants = Restaurant.joins(reviews: :user).where(reviews: {user: current_user }).distinct.page(params[:page]).per(params[:per])
    else
      restaurants = Restaurant.filter_data(params).page(params[:page]).per(params[:per])
    end
    meta_pagination = { 
      total_pages: restaurants.total_pages,
      current_page: restaurants.current_page,
      next_page: restaurants.next_page,
      prev_page: restaurants.prev_page 
    }

    render json:
      RestaurantSerializer.new(
        restaurants,
        params: { current_user: current_user },
        meta: {
          total: restaurants.total_count,
          pagination: meta_pagination
        }
      )
  end

  def recommendations
    if !current_user.user_recommendations.blank?
      restaurants = Restaurant.where(id: current_user.user_recommendations.last.recommendations.map { |h,k| h["restaurant_id"]} ).filter_data(params)
    else
      restaurants = Restaurant.order(stars: :desc).filter_data(params).limit(10)
    end

    render json:
      RestaurantSerializer.new(
        restaurants,
        params: { current_user: current_user },
      )
  end

  def rating
    user_review = Review.new(rating_params)
    if user_review.save
      render json: { message: "rating sucessfully saved" }
    else
      render json: {message: user_review.errors.full_messages }, status: 404
    end
  end

  def favorite
    user_favorite = Favorite.find_by(fav_params)
    if !user_favorite.present?
      user_favorite = Favorite.new(fav_params)
      if user_favorite.save
        render json: { message: "Favorited sucessfully saved" }
      else
        render json: {message: user_favorite.errors.full_messages }, status: 404
      end
    else
      user_favorite.destroy
      render json: { message: "Unfavorited sucessfully" }
    end
  end

  private

  def rating_params
    params.require(:rating).permit(:business_id, :rating)
  end

  def find_restaurant
    @restaurant = Restaurant.find_by(id: params[:id])
  end

  def rating_params
    params.require(:rating).permit(:stars).tap do |whitelisted|
      whitelisted[:user_id] = current_user&.id
      whitelisted[:restaurant_id] = @restaurant.id
    end
  end

  def fav_params
    hash = {}
    hash[:user_id] = current_user&.id
    hash[:restaurant_id] = @restaurant.id
    hash
  end


end
