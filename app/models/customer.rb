class Customer < ApplicationRecord
  has_one :address, as: :addressable, dependent: :destroy
  accepts_nested_attributes_for :address, allow_destroy: true
  belongs_to :shop, optional: true
end
