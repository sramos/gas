class AddUserIdToRefuel < ActiveRecord::Migration[5.1]
  def change
    add_column :refuels, :user_id, :integer, null: false
  end
end
