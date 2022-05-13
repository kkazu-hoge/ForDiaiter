class CreateColumns < ActiveRecord::Migration[6.1]
  def change
    create_table :columns do |t|
      t.string :title,    null: false
      t.text :summary,    null: false

      t.timestamps
    end
  end
end
