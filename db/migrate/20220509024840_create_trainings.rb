class CreateTrainings < ActiveRecord::Migration[6.1]
  def change
    create_table :trainings do |t|
      t.string :name,         null: false
      t.integer :mets_value,  null: false
      t.text :summary,        null: false

      t.timestamps
    end
  end
end
