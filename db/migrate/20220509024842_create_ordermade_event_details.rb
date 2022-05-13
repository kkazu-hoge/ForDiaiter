class CreateOrdermadeEventDetails < ActiveRecord::Migration[6.1]
  def change
    create_table :ordermade_event_details do |t|
      t.integer :ordermade_event_id,  null: false
      t.string :training_id,          null: false

      t.timestamps
    end
  end
end
