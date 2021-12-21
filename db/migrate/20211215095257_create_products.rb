class CreateProducts < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :shopify_id
      t.string :title
      t.string :vendor
      t.string :product_type
      t.string :handle
      t.string :status
    end
  end
end
