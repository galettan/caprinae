class AddPrintDetailsToProject < ActiveRecord::Migration
  def change
    add_column :projects, :test_print, :boolean, :default => 0
    add_column :projects, :colors, :integer, :default => 0
    add_column :projects, :various_input, :boolean, :default => 0
    add_column :projects, :good_sheets_qty, :integer, :default => 0
    add_column :projects, :finished_doc_qty, :integer, :default => 0
    add_column :projects, :let_raw, :boolean, :default => 1
    add_column :projects, :open_shape, :integer, :default => 0
    add_column :projects, :finished_shape, :integer, :default => 0
    add_column :projects, :filming, :integer, :default => 0
    add_column :projects, :shaping, :integer, :default => 0
    add_column :projects, :package, :integer, :default => 0
    add_column :projects, :delivery, :integer, :default => 0
    add_column :projects, :notice, :text
    add_column :projects, :outsourcing, :string
  end
end
