class AddIndexPjEventProjectId < ActiveRecord::Migration[6.1]
  def change
    add_index :pj_events, :project_id
  end
end
