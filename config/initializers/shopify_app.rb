ShopifyApp.configure do |config|
  config.application_name = "My Shopify App"
  config.old_secret = ""
  config.scope = "read_products, write_products, read_checkouts, read_customers, write_customers, read_themes, write_themes, read_orders, write_orders, read_assigned_fulfillment_orders, write_assigned_fulfillment_orders, read_content, write_content, read_discounts, write_discounts, read_draft_orders, write_draft_orders, read_files, write_files, read_fulfillments, write_fulfillments, read_gift_cards, write_gift_cards, read_inventory, write_inventory, read_legal_policies, read_locales,write_locales, read_locations, read_marketing_events, write_marketing_events, read_merchant_managed_fulfillment_orders, write_merchant_managed_fulfillment_orders, read_price_rules, write_price_rules, read_product_listings, read_reports, write_reports, read_resource_feedbacks, write_resource_feedbacks, read_shipping, write_shipping, read_shopify_payments_disputes, read_shopify_payments_payouts, read_third_party_fulfillment_orders, write_third_party_fulfillment_orders, write_order_edits" # Consult this page for more scope options:
                                  # https://help.shopify.com/en/api/getting-started/authentication/oauth/scopes
  config.embedded_app = true
  config.after_authenticate_job = false
  config.api_version = "2021-10"
  config.shop_session_repository = 'Shop'

  config.reauth_on_access_scope_changes = true

  config.allow_jwt_authentication = true
  config.allow_cookie_authentication = false

  config.api_key = ENV.fetch('SHOPIFY_API_KEY', '').presence
  config.secret = ENV.fetch('SHOPIFY_API_SECRET', '').presence
  if defined? Rails::Server
    raise('Missing SHOPIFY_API_KEY. See https://github.com/Shopify/shopify_app#requirements') unless config.api_key
    raise('Missing SHOPIFY_API_SECRET. See https://github.com/Shopify/shopify_app#requirements') unless config.secret
  end
end

# ShopifyApp::Utils.fetch_known_api_versions                        # Uncomment to fetch known api versions from shopify servers on boot
# ShopifyAPI::ApiVersion.version_lookup_mode = :raise_on_unknown    # Uncomment to raise an error if attempting to use an api version that was not previously known
