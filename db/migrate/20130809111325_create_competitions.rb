class CreateCompetitions < ActiveRecord::Migration
  def change
    create_table :competitions do |t|
      t.string :title
      t.datetime :entries_open_at
      t.datetime :entries_close_at
      t.datetime :results_published_at
      t.text :notes

      t.timestamps
    end
  end
end
