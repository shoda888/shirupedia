class AddTokenToProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :token, :string
  end
end
