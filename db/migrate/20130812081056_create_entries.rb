class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.references :user, index: true
      t.references :competition, index: true
      t.references :section, index: true
      t.references :rating
      t.string :title
      t.string :photo
      t.text :notes

      t.timestamps
    end
  end
end
