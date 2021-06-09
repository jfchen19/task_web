class AddDefaultStateToTask < ActiveRecord::Migration[6.1]
  def change
    change_column_default :tasks, :state, :prending
  end
end
