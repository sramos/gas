class AddFullToRefuel < ActiveRecord::Migration[5.1]
  def change
    add_column :refuels, :full, :boolean, default: true, null: false
  end
end

