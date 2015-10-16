class AddStateAndArchiveToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :archived, :boolean, default: false
    add_column :projects, :state, :integer, default: 0
  end
end
