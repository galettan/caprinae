class RemovePrintDefaultsFromProject < ActiveRecord::Migration
  def change
    change_column_default :projects, :colors, nil
    change_column_default :projects, :open_shape, nil
    change_column_default :projects, :finished_shape, nil
    change_column_default :projects, :filming, nil
    change_column_default :projects, :shaping, nil
    change_column_default :projects, :package, nil
    change_column_default :projects, :delivery, nil
    change_column_default :papers, :shape, 0
    change_column_default :projects, :estimated_time, 0
  end
end
