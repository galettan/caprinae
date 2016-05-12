class ModifyProjects < ActiveRecord::Migration
  def change
    reversible do |dir|
      change_table :projects do |t|
        dir.up {t.change :good_sheets_qty, :string}
        dir.up {t.change :finished_doc_qty, :string}
        dir.up {t.string :special_shape}
        dir.up {t.string :diverse_shape}
        dir.up {t.string :photo_credit}
        dir.up {t.string :photo_price}
        dir.up {t.string :paper_gtp}
        dir.up {t.string :send_gtp}

        dir.down {t.change :good_sheets_qty, :integer}
        dir.down {t.change :finished_doc_qty, :integer}
        dir.down {t.remove :special_shape}
        dir.down {t.remove :diverse_shape}
        dir.down {t.remove :photo_credit}
        dir.down {t.remove :photo_price}
        dir.down {t.remove :paper_gtp}
        dir.down {t.remove :send_gtp}
      end
    end
  end
end
