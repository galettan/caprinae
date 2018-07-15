class AddShapingsToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :shapingtwo, :integer
    add_column :projects, :shapingthree, :integer
  end
end
