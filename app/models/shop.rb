# frozen_string_literal: true
class Shop < ActiveRecord::Base
  include ShopifyApp::ShopSessionStorageWithScopes

  has_one :address, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :address, allow_destroy: true
  has_many :customers, dependent: :destroy
  has_many :products, dependent: :destroy

  def api_version
    ShopifyApp.configuration.api_version
  end

  def self.store(auth_session)
    ShopifyApiService.new(auth_session).activate_session
    shopify_shop = ShopifyApiService.new(auth_session).current_shop
    shopify_customers = ShopifyApiService.new(auth_session).fetch_customers
    shopify_products = ShopifyApiService.new(auth_session).fetch_products

    shop = Shop.find_or_initialize_by(shopify_domain: shopify_shop.domain)
    save_shop_data(shop, auth_session, shopify_shop)
    save_shop_customers_data(shop, shopify_customers)
    save_shop_products_data(shop, shopify_products)

    shop.id
  end

  def self.save_shop_products_data(shop, shopify_products)
    products = Product.upsert_all product_attributes(shop, shopify_products)
    save_product_variants(shopify_products, products.to_a)
  end

  def self.save_shop_customers_data(shop, shopify_customers)
    customers = Customer.upsert_all customer_attributes(shop, shopify_customers)
    Address.upsert_all address_attributes(shopify_customers, customers.to_a)
  end

  def self.save_shop_data(shop, auth_session, shopify_shop)
    shop_attributes = {
      shopify_token: auth_session.token,
      access_scopes: auth_session.access_scopes,
      shopify_id: shopify_shop.id,
      shopify_name: shopify_shop.name,
      shopify_email: shopify_shop.email,
      shopify_timezome: shopify_shop.timezone,
      shopify_phone: shopify_shop.phone,
      address_attributes: {
        province: shopify_shop.province,
        country: shopify_shop.country,
        address1: shopify_shop.address1,
        address2: shopify_shop.address2,
        zip: shopify_shop.zip,
        city: shopify_shop.city,
        country_name: shopify_shop.country_name
      }
    }
    shop.update! shop_attributes
  end

  def self.save_product_variants(shopify_products, product_ids)
    shopify_products.each_with_index do |shopify_product, index|
      Variant.upsert_all variant_attributes(shopify_product.variants, index, product_ids)
    end
  end

  def self.variant_attributes(variants, index, product_ids)
    variants.map do |variant|
      {
        shopify_id: variant.id,
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
        requires_shipping: variant.requires_shipping,
        product_id: product_ids[index]["id"]
      }
    end
  end

  def self.product_attributes(shop, shopify_products)
    shopify_products.map do |product|
      {
        shopify_id: product.id,
        title: product.title,
        vendor: product.vendor,
        product_type: product.product_type,
        handle: product.handle,
        status: product.status,
        shop_id: shop.id
      }
    end
  end

  def self.address_attributes(shopify_customers, customer_ids)
    shopify_customers.map.with_index do |shopify_customer, index|
      {
        province: shopify_customer.default_address.province,
        country: shopify_customer.default_address.country,
        address1: shopify_customer.default_address.address1,
        address2: shopify_customer.default_address.address2,
        zip: shopify_customer.default_address.zip,
        city: shopify_customer.default_address.city,
        country_name: shopify_customer.default_address.country_name,
        addressable_id: customer_ids[index]["id"],
        addressable_type: Customer.name
      }
    end
  end

  def self.customer_attributes(shop, shopify_customers)
    shopify_customers.map do |customer|
      {
        shopify_id: customer.id,
        email: customer.email,
        accepts_marketing: customer.accepts_marketing,
        first_name: customer.first_name,
        last_name: customer.last_name,
        orders_count: customer.orders_count,
        state: customer.state,
        total_spent: customer.total_spent,
        last_order_id: customer.last_order_id,
        phone: customer.phone,
        shop_id: shop.id
      }
    end
  end
end
