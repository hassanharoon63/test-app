class ImportCustomers
  include Interactor

  def call
    save_shop_customers_data(context.shop, context.shopify_customers)
  end

  private

  def save_shop_customers_data(shop, shopify_customers)
    customers = Customer.upsert_all customer_attributes(shop, shopify_customers)
    Address.upsert_all address_attributes(shopify_customers, customers.to_a)
  end

  def address_attributes(shopify_customers, customer_ids)
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

  def customer_attributes(shop, shopify_customers)
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
