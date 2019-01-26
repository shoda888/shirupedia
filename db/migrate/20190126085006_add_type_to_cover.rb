class AddTypeToCover < ActiveRecord::Migration[5.1]
  def change
    add_column :covers, :role, :integer, default: 1
  end
end
