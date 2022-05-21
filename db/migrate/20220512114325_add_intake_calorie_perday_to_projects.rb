class AddIntakeCaloriePerdayToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :intake_calorie_perday, :integer
  end
end
