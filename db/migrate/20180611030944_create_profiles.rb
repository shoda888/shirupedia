class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.string :avatar
      t.string :grade, comment: '学年'
      t.string :school, comment: '学院'
      t.string :department, comment: '系'
      t.string :lesson
      t.integer :user_id

      t.timestamps
    end
  end
end
