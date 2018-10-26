class ProductItem < ApplicationRecord
  include GCSImage

  belongs_to :product
end
