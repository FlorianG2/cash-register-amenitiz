class CreateCarts < ActiveRecord::Migration[7.0]
  def change
    create_table :carts do |t|
      t.decimal :total, precision: 5, scale: 2
      t.references :cart_product, null: false, foreign_key: true

      t.timestamps
    end
  end
end
