class CreateBookings < ActiveRecord::Migration[8.0]
  def change
    create_table :bookings do |t|
      t.references :tour, null: false, foreign_key: true
      t.string :full_name
      t.string :email
      t.string :phone_number
      t.string :payment_method

      t.timestamps
    end
  end
end
