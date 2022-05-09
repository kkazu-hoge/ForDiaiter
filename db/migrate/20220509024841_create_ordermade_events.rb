class CreateOrdermadeEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :ordermade_events do |t|
      t.integer :stress_level_param,    null: false
      t.integer :activity_type_param,   null: false
      t.integer :place_param,           null: false
      t.integer :equipment_param,       null: false
      t.integer :burn_calories,         null: false

      t.timestamps
    end
  end
end
