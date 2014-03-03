class AddShortRatingToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :short, :string
  end
end
