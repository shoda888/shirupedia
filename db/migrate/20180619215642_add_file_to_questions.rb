class AddFileToQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :file, :string
  end
end
