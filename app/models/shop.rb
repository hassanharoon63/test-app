# frozen_string_literal: true
class Shop < ActiveRecord::Base
  include ShopifyApp::ShopSessionStorageWithScopes

  has_one :address, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :address
  has_many :customers, dependent: :destroy
  has_many :products, dependent: :destroy

  def api_version
    ShopifyApp.configuration.api_version
  end

  def self.store(auth_session)
    ShopifyApiService.activate_session auth_session
    shopify_shop = ShopifyApiService.fetch_current_shop
    shopify_customers = ShopifyApiService.fetch_customers
    shopify_products = ShopifyApiService.fetch_products

    shop = Shop.find_or_initialize_by(shopify_domain: shopify_shop.domain)

    ImportData.call(
      shop: shop,
      auth_session: auth_session,
      shopify_shop: shopify_shop,
      shopify_customers: shopify_customers,
      shopify_products: shopify_products
    )

    shop.id
  end
end
