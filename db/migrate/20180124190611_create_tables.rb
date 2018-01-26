class CreateTables < ActiveRecord::Migration[5.1]
  def change
    create_table :tables do |t|
      t.string :name
      t.integer :minimum_capacity
      t.integer :maximum_capacity
      t.references :restaurant, index: true
      t.timestamps
    end
  end
end
