class ChangeProjectValidationDateToDeliveryDate < ActiveRecord::Migration
  def change
    rename_column :projects, :validation_date, :delivery_date
  end
end
