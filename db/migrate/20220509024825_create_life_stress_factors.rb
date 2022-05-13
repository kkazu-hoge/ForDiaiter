class CreateLifeStressFactors < ActiveRecord::Migration[6.1]
  def change
    create_table :life_stress_factors do |t|
      t.string :name,           null: false
      t.integer :coefficient,   null: false

      t.timestamps
    end
  end
end
