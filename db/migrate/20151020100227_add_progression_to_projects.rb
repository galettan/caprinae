class AddProgressionToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :progression, :integer
  end
end
