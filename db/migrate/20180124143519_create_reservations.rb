class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.datetime :reservation_time
      t.integer :guest_count
      t.string :status
      t.references :restaurant, index: true
      t.references :guest, index: true
      t.references :table, index: true
      t.timestamps
    end
  end
end
