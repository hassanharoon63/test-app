class ShopifyApiService
  def initialize(auth_session)
    @auth_session = auth_session
  end

  def activate_session
    ShopifyAPI::Base.activate_session(@auth_session)
  end

  def current_shop
    ShopifyAPI::Shop.current
  end

  def fetch_customers
    ShopifyAPI::Customer.all
  end

  def fetch_products
    ShopifyAPI::Product.all
  end
end
