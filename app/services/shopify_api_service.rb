class ShopifyApiService
  def activate_session(auth_session)
    ShopifyAPI::Base.activate_session(auth_session)
  end

  def fetch_current_shop
    ShopifyAPI::Shop.current
  end

  def fetch_customers
    ShopifyAPI::Customer.all
  end

  def fetch_products
    ShopifyAPI::Product.all
  end
end
