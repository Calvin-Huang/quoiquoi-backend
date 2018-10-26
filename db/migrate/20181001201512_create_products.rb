class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.references :product_category, foreign_key: true
      t.float :price

      t.timestamps
    end
  end
end