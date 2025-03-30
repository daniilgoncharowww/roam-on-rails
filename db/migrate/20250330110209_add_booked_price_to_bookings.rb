class AddBookedPriceToBookings < ActiveRecord::Migration[8.0]
  def change
    add_column :bookings, :booked_price, :decimal, precision: 10, scale: 2
  end
end
