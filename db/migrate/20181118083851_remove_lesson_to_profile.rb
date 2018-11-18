class RemoveLessonToProfile < ActiveRecord::Migration[5.1]
  def change
    remove_column :profiles, :lesson, :string
  end
end
