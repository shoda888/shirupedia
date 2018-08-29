class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|

      t.string :aasm_state
      t.string :tag
      t.string :file
      t.integer :user_id
      t.integer :question_id
      t.timestamps
    end
  end
end
