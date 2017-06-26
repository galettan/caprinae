class AddNoteToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :note, :text
  end
end
