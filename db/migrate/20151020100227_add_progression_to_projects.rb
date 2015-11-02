class AddProgressionToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :progression, :integer, :default => 0
  end
end
