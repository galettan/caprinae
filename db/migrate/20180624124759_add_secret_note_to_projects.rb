class AddSecretNoteToProjects < ActiveRecord::Migration[5.0]
  def change
    reversible do |dir|
      change_table :projects do |t|
        dir.up {t.text :secret_note}
        dir.up {t.integer :orientation}
        dir.down {t.remove :secret_note}
        dir.down {t.remove :orientation}
      end
    end
  end
end
