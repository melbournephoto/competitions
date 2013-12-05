class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.references :user, index: true
      t.references :competition, index: true
      t.references :section, index: true
      t.references :rating
      t.references :grade, index: true
      t.string :title
      t.string :photo
      t.text :notes
      t.integer :order, index: true, null: false
      t.integer :photo_file_size
      t.integer :photo_width
      t.integer :photo_height
      t.text :exif

      t.timestamps
    end
  end
end
