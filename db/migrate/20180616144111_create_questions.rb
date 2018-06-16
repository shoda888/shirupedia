class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.string :title
      t.string :content
      t.string :aasm_state
      t.string :tag
      t.integer :amount_paid
      t.integer :user_id

      t.timestamps
    end
  end
end
