class ChangeDefaultStateToTask < ActiveRecord::Migration[6.1]
  def change
    change_column_default :tasks, :state, from: :prending, to: :pending
  end
end
