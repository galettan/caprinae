class PaperModel < ActiveRecord::Migration
  def change
    create_table :papers do |p|
      p.integer :paper
      p.integer :density
      p.integer :shape
      p.integer :project_id
    end
  add_foreign_key :papers, :projects, column: :project_id, on_delete: :nullify
  end

end
