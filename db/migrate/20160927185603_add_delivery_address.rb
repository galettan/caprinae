class AddDeliveryAddress < ActiveRecord::Migration
  def change
    reversible do |dir|
      change_table :projects do |t|
        dir.up {t.string :delivery_address}
        
        dir.down {t.remove :delivery_address}
      end
    end
  end
end
