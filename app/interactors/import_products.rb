class ImportProducts
  include Interactor

  def call
    save_shop_products_data(context.shop, context.shopify_products)
  end

  private

  def save_shop_products_data(shop, shopify_products)
    products = Product.upsert_all product_attributes(shop, shopify_products)
    save_product_variants(shopify_products, products.to_a)
  end

  def save_product_variants(shopify_products, product_ids)
    shopify_products.each_with_index do |shopify_product, index|
      Variant.upsert_all variant_attributes(shopify_product.variants, index, product_ids)
    end
  end

  def variant_attributes(variants, index, product_ids)
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

  def product_attributes(shop, shopify_products)
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
end
