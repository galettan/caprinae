class AddDatesToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :first_feedback, :datetime
    add_column :projects, :validation_date, :datetime
    add_column :projects, :good_to_print, :datetime
  end
end
