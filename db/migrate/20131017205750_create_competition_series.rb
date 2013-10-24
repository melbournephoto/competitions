class CreateCompetitionSeries < ActiveRecord::Migration
  def change
    create_table :competition_series do |t|
      t.string :title

      t.timestamps
    end
  end
end
