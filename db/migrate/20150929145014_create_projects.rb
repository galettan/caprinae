class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.integer :number
      t.integer :owner_id, nul: false
      t.integer :worker_id, nul: true
      t.timestamps null: false
    end
    add_foreign_key :projects, :users, column: :owner_id, on_delete: :nullify
    add_foreign_key :projects, :users, column: :worker_id, on_delete: :nullify
     
  end
end
