class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.string :avatar
      t.string :grade
      t.string :department
      t.string :lesson
      t.integer :user_id

      t.timestamps
    end
  end
end
