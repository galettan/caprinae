class AddPriorityToProject < ActiveRecord::Migration
  def change
    add_column :projects, :priority, :integer, default: 0
  end
end
