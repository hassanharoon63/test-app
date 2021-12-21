class AddExtraColumnsToShop < ActiveRecord::Migration[6.0]
  def change
    add_column :shops, :shopify_id, :string
    add_column :shops, :shopify_name, :string
    add_column :shops, :shopify_email, :string
    add_column :shops, :shopify_timezome, :string
    add_column :shops, :shopify_phone, :string
  end
end
