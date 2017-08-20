class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.belongs_to :user, foreign_key: true
      t.string :title
      t.text :details
      t.datetime :time_begin
      t.datetime :time_end
      t.timestamps
    end
  end
end
