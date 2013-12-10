class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.string :title
      t.integer :points, null: false, default: 0
      t.integer :max_per_grade, null: false, default: 0
      t.integer :max_per_competition, null: false, default: 0
      t.integer :order, null: false, default: 0

      t.timestamps
    end
  end
end
