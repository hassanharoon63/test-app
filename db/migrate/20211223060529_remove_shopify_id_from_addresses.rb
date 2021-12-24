class RemoveShopifyIdFromAddresses < ActiveRecord::Migration[6.0]
  def change
    remove_column :addresses, :shopify_id, :string
  end
end
