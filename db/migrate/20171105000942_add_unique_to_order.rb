class AddUniqueToOrder < ActiveRecord::Migration
  def change
    add_index :sections, [:competition_id, :order], unique: true
  end
end
