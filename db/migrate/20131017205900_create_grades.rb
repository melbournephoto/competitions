class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.references :competition_series, index: true
      t.string :title

      t.timestamps
    end
  end
end
