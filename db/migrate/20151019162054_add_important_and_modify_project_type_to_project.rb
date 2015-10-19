class AddImportantAndModifyProjectTypeToProject < ActiveRecord::Migration
  def change
    change_column :projects, :project_type, :integer
    add_column :projects, :important, :text
    add_column :projects, :details, :text
  end
end
