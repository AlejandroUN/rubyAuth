class AddPrivacyToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :privacy, :string
  end
end
