class CreatePjEventDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :pj_event_details do |t|
      t.integer :pj_event_id,       null: false
      t.integer :training_id,       null: false
      t.integer :activity_minutes,  null: false, default: 0
      t.integer :burn_calories,     null: false, default: 0

      t.timestamps
    end
  end
end
