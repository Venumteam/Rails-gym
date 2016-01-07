class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.references :product
      t.references :order
      t.decimal :unit_price,  precision: 12, scale:  3
      t.decimal :total_price,  precision: 12, scale:  3
      t.integer :quantity
      t.timestamps null: false
    end
  end
end
