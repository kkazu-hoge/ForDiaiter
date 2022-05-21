class AddStartTimeToPjEvent < ActiveRecord::Migration[6.1]
  def change
    add_column :pj_events, :start_time, :datetime, null: false
  end
end
