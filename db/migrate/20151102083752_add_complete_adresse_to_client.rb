class AddCompleteAdresseToClient < ActiveRecord::Migration
  def change
    add_column :clients, :adress_complement, :string
    rename_column :clients, :town, :city
  end
end
