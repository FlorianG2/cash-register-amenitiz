class CreateCartProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :cart_products do |t|
      t.integer :quantity
      t.decimal :total, precision: 5, scale: 2

      t.timestamps
    end
  end
end
