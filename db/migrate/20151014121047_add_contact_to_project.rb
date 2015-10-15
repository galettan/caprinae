class AddContactToProject < ActiveRecord::Migration
  def change
    add_column :projects, :contact_id, :integer
    add_foreign_key :projects, :contacts, column: :contact_id, on_delete: :nullify
  end
end
