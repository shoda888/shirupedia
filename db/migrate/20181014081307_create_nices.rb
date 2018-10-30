class CreateNices < ActiveRecord::Migration[5.1]
  def change
    create_table :nices do |t|
      t.integer :user_id
      t.integer :cover_id

      t.timestamps

      t.index :user_id
      t.index :cover_id
      t.index [:user_id, :cover_id], unique: true
    end
  end
end
