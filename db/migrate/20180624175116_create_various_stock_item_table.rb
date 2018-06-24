class CreateVariousStockItemTable < ActiveRecord::Migration[5.0]
  def change
    create_table :various_stock_items do |t|
      t.string :name
      t.integer :quantity
      t.integer :various_stock_id
      t.timestamps null: false
    end
    add_foreign_key :various_stock_items, :various_stocks, column: :various_stock_id, on_delete: :nullify
  end
end
