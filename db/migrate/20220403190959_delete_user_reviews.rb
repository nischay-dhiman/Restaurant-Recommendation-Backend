class DeleteUserReviews < ActiveRecord::Migration[6.0]
  def change
    drop_table :user_recommendations
  end
end
