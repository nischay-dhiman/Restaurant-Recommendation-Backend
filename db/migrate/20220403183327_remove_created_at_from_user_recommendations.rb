class RemoveCreatedAtFromUserRecommendations < ActiveRecord::Migration[6.0]
  def change
    remove_column :user_recommendations, :created_at
  end
end
