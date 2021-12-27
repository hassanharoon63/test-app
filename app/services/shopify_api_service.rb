class ShopifyApiService
  def self.activate_session(auth_session)
    ShopifyAPI::Base.activate_session(auth_session)
  end

  def self.fetch_current_shop
    ShopifyAPI::Shop.current
  end

  def self.fetch_customers
    ShopifyAPI::Customer.all
  end

  def self.fetch_products
    ShopifyAPI::Product.all
  end
end
