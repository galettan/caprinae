class AddCarrierDetailToProject < ActiveRecord::Migration
  def change
    reversible do |dir|
      change_table :projects do |t|
        dir.up {t.integer :carrier_id}
        dir.up {t.string :tracking_nbr}
        dir.up {t.integer :package_nbr}
        dir.up {t.boolean :tracking_email}

        dir.down {t.remove :carrier_id}
        dir.down {t.remove :tracking_nbr}
        dir.down {t.remove :package_nbr}
        dir.down {t.remove :tracking_email}
      end
    end
  end
end
