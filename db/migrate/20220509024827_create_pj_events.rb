class CreatePjEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :pj_events do |t|
      t.integer :project_id,  null: false
      t.date :action_day,     null: false

      t.timestamps
    end
  end
end
