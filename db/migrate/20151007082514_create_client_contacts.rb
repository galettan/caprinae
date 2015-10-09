class CreateClientContacts < ActiveRecord::Migration
  def change
    create_table :client_contacts do |t|
      t.string :last_name
      t.string :first_name
      t.string :phone_nbr
      t.string :email
      t.integer :client_id
      t.timestamps null: false
    end
    add_foreign_key :client_contacts, :clients, column: :client_id, on_delete: :nullify

  end
end
