class AddIndexPjEventDetailPjEventId < ActiveRecord::Migration[6.1]
  def change
    add_index :pj_event_details, :pj_event_id
  end
end
