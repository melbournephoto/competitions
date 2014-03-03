class AddDeletedAtToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :deleted_at, :datetime
    add_index :entries, :deleted_at
  end
end
