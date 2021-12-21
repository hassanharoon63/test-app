class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :shopify_id
      t.string :province
      t.string :country
      t.string :address1
      t.string :zip
      t.string :city
      t.string :country_name
      t.string :address2
      t.references :addressable, polymorphic: true
    end
  end
end
