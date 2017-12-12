class CreateRefuels < ActiveRecord::Migration[5.1]
  def change
    create_table :refuels do |t|
      t.date    :date, null: false
      t.decimal :odometer, precision: 9, scale: 3, null: false
      t.decimal :volume, precision: 6, scale: 3, null: false
      t.decimal :price, precision: 4, scale: 3
      t.decimal :cost, precision: 5, scale: 2

      t.timestamps
    end
  end
end
