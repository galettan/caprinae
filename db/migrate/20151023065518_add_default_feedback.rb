class AddDefaultFeedback < ActiveRecord::Migration
  def change
    change_column_default :projects, :feedback_number, 3
  end
end
