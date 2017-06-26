class AddNoteToProjects < ActiveRecord::Migration[5.0]
  def change
    reversible do |dir|
      change_table :projects do |t|
        dir.up {t.text :note}

        dir.down {t.remove :note}
      end
    end
  end
end
