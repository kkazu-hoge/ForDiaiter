class AddCustomerIdToContact < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts, :customer_id, :integer, null: false
  end
end
