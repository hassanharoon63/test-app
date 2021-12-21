class AddShopRefToCustomers < ActiveRecord::Migration[6.0]
  def change
    add_reference :customers, :shop, null: true, foreign_key: true
  end
end
