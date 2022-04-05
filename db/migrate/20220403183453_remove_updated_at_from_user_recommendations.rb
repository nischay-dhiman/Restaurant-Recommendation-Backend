class RemoveUpdatedAtFromUserRecommendations < ActiveRecord::Migration[6.0]
  def change
    remove_column :user_recommendations, :updated_at
  end
end
