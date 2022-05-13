class CreatePlanPjEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :plan_pj_events do |t|
      t.integer :project_id,  null: false

      t.timestamps
    end
  end
end
