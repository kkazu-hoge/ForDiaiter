class AddIndexPlanPjEventProjectId < ActiveRecord::Migration[6.1]
  def change
    add_index :plan_pj_events, :project_id
  end
end
