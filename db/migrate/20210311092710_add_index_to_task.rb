class AddIndexToTask < ActiveRecord::Migration[6.1]
  def change
    add_index :tasks, :created_at
    add_index :tasks, :start_time
    add_index :tasks, :end_time
  end
end
