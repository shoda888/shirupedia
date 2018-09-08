class CreateCovers < ActiveRecord::Migration[5.1]
  def change
    create_table :covers do |t|
      t.references :coverable, polymorphic: true
      t.string :photo_message

      t.timestamps
    end
  end
end
