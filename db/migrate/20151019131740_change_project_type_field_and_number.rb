class ChangeProjectTypeFieldAndNumber < ActiveRecord::Migration
  def change
    change_column :projects, :project_type, :string
    change_column :projects, :number, :string
  end  
end
