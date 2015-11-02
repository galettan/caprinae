class ModifyTestPrintFromProjects < ActiveRecord::Migration
  def change
    change_column :projects, :test_print, :integer, :default => 0
    change_column_default :projects, :estimated_time, 1
  end
end
