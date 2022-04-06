class Restaurant < ApplicationRecord
  has_many :reviews
  has_many :favorites
  mount_uploader :restaurant_image, RestaurantImageUploader

  def self.filter_data(params)
    list = self
    list = list.where('name LIKE ?', "%#{params[:name]}%") if !params[:name].blank?
    list = list.where('stars > ?', params[:stars]) if !params[:stars].blank?
    list = list.where('categories LIKE ?', "%#{params[:country]}%") if !params[:country].blank?
    list
  end
end
