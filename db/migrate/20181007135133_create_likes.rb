class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.integer :user_id, null: false
      t.integer :question_id, null: false

      t.timestamps

      t.index :user_id
      t.index :question_id
      t.index [:user_id, :question_id], unique: true
    end
  end
end
