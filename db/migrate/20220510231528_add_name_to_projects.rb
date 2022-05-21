class AddNameToProjects < ActiveRecord::Migration[6.1]
  def change
    add_column :projects, :name, :string, null: false
  end
end
