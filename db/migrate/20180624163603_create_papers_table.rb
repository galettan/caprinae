class CreatePapersTable < ActiveRecord::Migration[5.0]
  def change
    create_table :paperstock_items do |t|
      t.string :name
      t.integer :thirtytwofortyfive
      t.integer :fiftytwoseventytwo
      t.integer :paperstock_id
      t.integer :toorder
      t.timestamps null: false
    end
    add_foreign_key :paperstock_items, :paperstocks, column: :paperstock_id, on_delete: :nullify
  end
end
