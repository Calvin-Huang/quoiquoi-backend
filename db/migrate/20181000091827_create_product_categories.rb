class CreateProductCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :product_categories do |t|
      t.integer :parent_id
      t.string :group
      t.integer :order

      t.timestamps
    end
  end
end
