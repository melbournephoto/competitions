class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.references :competition_series, index: true
      t.string :title
      t.integer :order, null: false, default: 0

      t.timestamps
    end
  end
end
