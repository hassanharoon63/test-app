class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      t.string :shopify_id
      t.string :email
      t.boolean :accepts_marketing
      t.string :first_name
      t.string :last_name
      t.integer :orders_count
      t.string :state
      t.string :total_spent
      t.string :last_order_id
      t.string :phone
      t.string :addresses, array: true, default: []
    end
  end
end
