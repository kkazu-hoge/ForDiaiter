class AddIndexPlanPjEventDetailPlanPjEventId < ActiveRecord::Migration[6.1]
  def change
    add_index :plan_pj_event_details, :plan_pj_event_id
  end
end
