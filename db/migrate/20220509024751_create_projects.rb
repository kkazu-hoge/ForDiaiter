class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.integer :customer_id,           null: false
      t.integer :life_stress_factor_id, null: false
      t.integer :sex,                   null: false
      t.integer :age,                   null: false
      t.integer :height,                null: false
      t.integer :weight,                null: false
      t.integer :target_weight,         null: false
      t.date :pj_start_day,             null: false
      t.date :pj_finish_day,            null: false
      t.integer :interval,              null: false

      t.timestamps
    end
  end
end
