class AddMandatoryTimeToProject < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :mandatory_time, :time
  end
end
