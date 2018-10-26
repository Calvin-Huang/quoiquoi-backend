class ProductCategory < ApplicationRecord
  extend GCSImage

  enum group: [:brand, :course, :gift_card]
end
