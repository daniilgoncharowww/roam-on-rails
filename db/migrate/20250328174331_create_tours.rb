class CreateTours < ActiveRecord::Migration[8.0]
  def change
    create_table :tours do |t|
      t.string :name
      t.decimal :price, precision: 10, scale: 2
      t.boolean :discounted
      t.text :description
      t.boolean :hidden
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
