class AddProjectCreationEmail < ActiveRecord::Migration
  def change
    reversible do |dir|
      change_table :projects do |t|
        dir.up {t.boolean :create_email}
        dir.down {t.remove :create_email}
      end
    end
  end
end
