class ListItems < ActiveRecord::Migration[5.0]
  def change
    create_table :list_items do |t|
      t.string :name
      t.integer :list_id
      t.timestamps
    end
    add_foreign_key :list_items, :lists, column: :list_id, on_delete: :nullify
  end
end
