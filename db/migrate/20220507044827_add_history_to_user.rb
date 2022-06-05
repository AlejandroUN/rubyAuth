class AddHistoryToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :history, :text, array: true, default: []
  end
end
