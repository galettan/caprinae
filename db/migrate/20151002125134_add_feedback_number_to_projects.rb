class AddFeedbackNumberToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :feedback_number, :integer
  end
end
