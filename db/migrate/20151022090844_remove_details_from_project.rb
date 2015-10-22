class RemoveDetailsFromProject < ActiveRecord::Migration
  def change
    remove_column :projects, :details, :text
    add_column :projects, :departure_date, :date
    
  end
end
