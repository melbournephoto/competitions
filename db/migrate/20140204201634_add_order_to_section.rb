class AddOrderToSection < ActiveRecord::Migration
  def change
    add_column :sections, :order, :integer, null: false, default: 0
  end
end
