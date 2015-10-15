class ChangeClientContactsToContact < ActiveRecord::Migration
  def change
    rename_table :client_contacts, :contacts
  end
end
