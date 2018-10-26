class CreateProductItems < ActiveRecord::Migration[5.2]
  def change
    create_table :product_items do |t|
      t.references :product, foreign_key: true
      t.float :price

      t.timestamps
    end
  end
end
