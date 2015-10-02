class ModifyProjectsDateTimeToDate < ActiveRecord::Migration
  def change
    change_column :projects, :first_feedback, :date
    change_column :projects, :validation_date, :date
    change_column :projects, :good_to_print, :date
  end
end
