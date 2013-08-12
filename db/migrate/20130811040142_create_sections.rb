class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.references :competition, index: true
      t.string :title
      t.integer :entry_limit
      t.integer :max_height
      t.integer :max_width
      t.integer :max_file_size

      t.timestamps
    end
  end
end
