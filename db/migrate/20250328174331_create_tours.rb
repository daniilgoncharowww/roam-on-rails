class CreateTours < ActiveRecord::Migration[8.0]
  def change
    create_table :tours do |t|
      t.string :name
      t.decimal :price, precision: 10, scale: 2
      t.boolean :discounted
      t.integer :discount_percent, default: 0
      t.text :description
      t.boolean :hidden

      t.timestamps
    end

    create_join_table :tours, :categories do |t|
      t.index :tour_id
      t.index :category_id
    end
  end
end
