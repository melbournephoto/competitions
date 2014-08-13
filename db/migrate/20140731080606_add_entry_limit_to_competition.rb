class AddEntryLimitToCompetition < ActiveRecord::Migration
  def change
    add_column :competitions, :entry_limit, :integer, null: false, default: 0
  end
end
