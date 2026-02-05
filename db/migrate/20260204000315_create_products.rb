class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :product_id, null: false
      t.string :name, null: false
      t.text :description
      t.string :category, null: false
      t.string :brand, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.decimal :old_price, precision: 10, scale: 2
      t.integer :stock, default: 0, null: false
      t.text :tags
      t.string :image_url
      t.boolean :active, default: true, null: false

      t.timestamps

      # Índices para performance
      t.index :product_id, unique: true
      t.index :name
      t.index :category
      t.index :brand
      t.index :price
      t.index [:active, :created_at]
    end
  end
end
