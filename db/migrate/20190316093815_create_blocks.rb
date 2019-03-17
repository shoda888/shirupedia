class CreateBlocks < ActiveRecord::Migration[5.1]
  def change
    create_table :blocks do |t|
      t.integer :user_id, null: false
      t.integer :target_user_id, null: false

      t.timestamps
      t.index [:user_id, :target_user_id], unique: true
      t.index :target_user_id
    end
  end
end
