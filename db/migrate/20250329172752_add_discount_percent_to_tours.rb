class AddDiscountPercentToTours < ActiveRecord::Migration[8.0]
  def change
    add_column :tours, :discount_percent, :integer
  end
end
