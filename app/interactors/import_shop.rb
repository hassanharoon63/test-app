class ImportShop
  include Interactor

  def call
    save_shop_data(context.shop, context.auth_session, context.shopify_shop)
  end

  private

  def save_shop_data(shop, auth_session, shopify_shop)
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
end
