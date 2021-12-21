class ApplicationController < ActionController::Base
  # before_action :create_session
  # before_action :save_data_to_db

  # private

  # def create_session
  #   shopify_session = ShopifyAPI::Session.new(domain: "hassans-test-store.myshopify.com", api_version: "2021-10", token: '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')
  #   ShopifyAPI::Base.activate_session(shopify_session)
  # end

  # def save_data_to_db
  #   shop = ShopifyAPI::Shop.current
  #   sh = Shop.find_by_shopify_domain(shop.domain)
  #   sh.update_attributes(shopify_shop_id: shop.id, shopify_shop_name: shop.name, shopify_shop_email: shop.email, shopify_shop_timezome: shop.timezone)
  #   sh.create_address(province: shop.province, country: shop.country, address1: shop.address1, zip: shop.zip, city: shop.city, country_code: shop.country_code, country_name: shop.country_name)
  # end
end
