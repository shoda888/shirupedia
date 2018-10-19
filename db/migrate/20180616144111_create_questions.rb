class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.string :title
      t.string :aasm_state
      t.integer :user_id
      t.string :text_message

      t.timestamps
    end
  end
end
