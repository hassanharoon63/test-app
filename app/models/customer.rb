class Customer < ApplicationRecord
  has_one :address, as: :addressable, dependent: :destroy
  belongs_to :shop, optional: true
end
