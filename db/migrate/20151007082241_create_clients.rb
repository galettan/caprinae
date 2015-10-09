class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
      t.string :street
      t.string :postal_code
      t.string :town
      t.timestamps null: false
    end
  end
end
