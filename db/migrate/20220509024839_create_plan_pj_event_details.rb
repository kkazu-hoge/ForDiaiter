class CreatePlanPjEventDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :plan_pj_event_details do |t|
      t.integer :plan_pj_event_id,  null: false
      t.integer :training_id,       null: false
      t.integer :activity_minutes,  null: false
      t.integer :burn_calories,     null: false

      t.timestamps
    end
  end
end
