class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :category
      t.float :price
      t.string :product_description
      t.string :image_product
      t.string :composition
      t.string :recommendation_for_use
      t.float :grams
      t.integer :count
      t.integer :likes_count, default: 0, null: false
      t.integer :comments_count, default: 0, null: false
      t.boolean :sale
      t.timestamps null: false
    end
  end
end
