class ChangeColumnToLifeStressFactor < ActiveRecord::Migration[6.1]
  def change
    change_column :life_stress_factors, :coefficient, :float, null: false
  end
end
