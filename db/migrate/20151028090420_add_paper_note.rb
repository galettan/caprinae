class AddPaperNote < ActiveRecord::Migration
  def change
    add_column :papers, :note, :text
    change_column_default :projects, :estimated_time, 5
  end
end
