class CreateCompetitionSeriesGrades < ActiveRecord::Migration
  def change
    create_table :competition_series_grades do |t|
      t.references :competition_series, index: true, null: false
      t.references :grade, index: true, null: false
      t.references :user, index: true, null: false

      t.timestamps
    end
  end
end
