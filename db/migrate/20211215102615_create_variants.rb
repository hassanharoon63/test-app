class CreateVariants < ActiveRecord::Migration[6.0]
  def change
    create_table :variants do |t|
      t.string :shopify_id
      t.string :title
      t.string :fulfillment_service
      t.boolean :taxable
      t.string :barcode
      t.float :grams
      t.string :image_id
      t.float :weight
      t.string :weight_unit
      t.string :inventory_item_id
      t.integer :inventory_quantity
      t.boolean :requires_shipping
      t.references :product, null: false, foreign_key: true
    end
  end
end
