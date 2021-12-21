# frozen_string_literal: true
class Shop < ActiveRecord::Base
  include ShopifyApp::ShopSessionStorageWithScopes

  has_one :address, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :address, allow_destroy: true
  has_many :customers, dependent: :nullify
  has_many :products, dependent: :destroy

  def api_version
    ShopifyApp.configuration.api_version
  end

  def self.store(auth_session)
    remote_shop = ShopifyAPI::Shop.current
    customers = ShopifyAPI::Customer.all
    products = ShopifyAPI::Product.all

    shop = Shop.find_or_initialize_by(shopify_domain: remote_shop.domain)

    shop.update_attributes(
      shopify_token: auth_session.token,
      access_scopes: auth_session.access_scopes,
      shopify_id: remote_shop.id,
      shopify_name: remote_shop.name,
      shopify_email: remote_shop.email,
      shopify_timezome: remote_shop.timezone,
      shopify_phone: remote_shop.phone,
      address_attributes: {
        province: remote_shop.province,
        country: remote_shop.country,
        address1: remote_shop.address1,
        address2: remote_shop.address2,
        zip: remote_shop.zip,
        city: remote_shop.city,
        country_name: remote_shop.country_name
      }
    )

    customers.each do |customer|
      cust = shop.customers.find_or_create_by(shopify_id: customer.id)

      cust.update_attributes(
        email: customer.email,
        accepts_marketing: customer.accepts_marketing,
        first_name: customer.first_name,
        last_name: customer.last_name,
        orders_count: customer.orders_count,
        state: customer.state,
        total_spent: customer.total_spent,
        last_order_id: customer.last_order_id,
        phone: customer.phone,
        address_attributes: {
          shopify_id: customer.addresses.first.id,
          province: customer.addresses.first.province,
          country: customer.addresses.first.country,
          address1: customer.addresses.first.address1,
          address2: customer.addresses.first.address2,
          zip: customer.addresses.first.zip,
          city: customer.addresses.first.city,
          country_name: customer.addresses.first.country_name
        }
      )
    end

    products.each do |product|
      prod = shop.products.find_or_create_by(shopify_id: product.id)
      prod.update_attributes(
        shopify_id: product.id,
        title: product.title,
        vendor: product.vendor,
        product_type: product.product_type,
        handle: product.handle,
        status: product.status
      )

      product.variants.each do |variant|
        vari = prod.variants.find_or_create_by(shopify_id: variant.id)

        vari.update_attributes(
          title: variant.title,
          fulfillment_service: variant.fulfillment_service,
          taxable: variant.taxable,
          barcode: variant.barcode,
          grams: variant.grams,
          image_id: variant.image_id,
          weight: variant.weight,
          weight_unit: variant.weight_unit,
          inventory_item_id: variant.inventory_item_id,
          inventory_quantity: variant.inventory_quantity,
          requires_shipping: variant.requires_shipping
        )
      end
    end

    shop.id
  end
end
