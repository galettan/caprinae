class AddTasksAndFeedbackToProjects < ActiveRecord::Migration
  def change
    create_table :tasks do |ta|
      ta.integer :duration
      ta.integer :project_id
      ta.integer :worker_id
      ta.text :description
      ta.timestamps null: false
    end
    
    create_table :feedbacks do |fe|
      fe.text :description
      fe.integer :project_id
      fe.integer :worker_id
      fe.timestamps null: false
    end
    
  add_column :projects, :estimated_time, :integer, :default => 0
  add_foreign_key :tasks, :projects, column: :project_id, on_delete: :nullify
  add_foreign_key :tasks, :users, column: :worker_id, on_delete: :nullify
  add_foreign_key :feedbacks, :projects, column: :project_id, on_delete: :nullify
  add_foreign_key :feedbacks, :users, column: :worker_id, on_delete: :nullify
  end

end
