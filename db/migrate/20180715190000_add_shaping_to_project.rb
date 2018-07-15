class AddShapingToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :shaping_one, :integer
    add_column :projects, :shaping_two, :integer
    add_column :projects, :shaping_three, :integer
    add_column :projects, :filming_id, :integer
    remove_column :projects, :shapingtwo, :integer
    remove_column :projects, :shapingthree, :integer
	add_foreign_key :projects, :list_items, column: :shaping_one, on_delete: :nullify
	add_foreign_key :projects, :list_items, column: :shaping_two, on_delete: :nullify
	add_foreign_key :projects, :list_items, column: :shaping_three, on_delete: :nullify
  add_foreign_key :projects, :list_items, column: :filming_id, on_delete: :nullify
  end
end
