class AddProjectContacts < ActiveRecord::Migration
  def change
    create_table :participants do |pc|
      pc.belongs_to :project, index: true
      pc.belongs_to :contact, index: true
      pc.timestamps null: false
    end
    remove_foreign_key :projects, column: :project_id
  end
end
