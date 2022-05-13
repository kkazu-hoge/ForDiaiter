class AddLastNameToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :last_name, :string, null: false
    add_column :customers, :first_name, :string, null: false
    add_column :customers, :public_name, :string, null: false
    add_column :customers, :sex, :integer, null: false
    add_column :customers, :birthday, :date, null: false
    add_column :customers, :height, :integer, null: false
    add_column :customers, :weight, :integer, null: false
    add_column :customers, :is_deleted, :boolean, null: false, default: false
  end
end
