class ChangeColumnToProjects < ActiveRecord::Migration[6.1]
  def change
    change_column :projects, :intake_calorie_perday, :integer, null: false
  end
end
