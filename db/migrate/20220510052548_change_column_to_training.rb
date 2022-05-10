class ChangeColumnToTraining < ActiveRecord::Migration[6.1]
  def change
    change_column :trainings, :mets_value, :float, null: false
  end
end
