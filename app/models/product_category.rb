class ProductCategory < ApplicationRecord
  extend GCSImage

  enum group: {
    highlight: 0,
    brand: 1,
    course: 2,
    gift_card: 3,
  }

  attr_accessor :name

  # belongs_to :parent, :class_name => 'ProductCategory'

  after_save :sync_to_redis
  before_create :append_new_order
  before_destroy :prepare_for_reorder
  after_destroy :reorder

  def group=(val)
    # Convert string to integer
    write_attribute :group, val.to_s.gsub(/\D/, '').to_i
  end

  def name
    Rails.cache.read("product_category:#{self.id}:#{I18n.locale}:name")
  end

  def name=(val)
    @name = val
  end

  private
  def sync_to_redis
    unless @name.blank?
      Rails.cache.write("product_category:#{self.id}:#{I18n.locale}:name", @name)
    end

    # Reset the cached variable
    @name = nil
  end

  def append_new_order
    last_order = ProductCategory.select(:order).order(order: :desc).first.order || 0
    self.order = last_order + 1
  end

  def prepare_for_reorder
    @previous_order = self.order
  end

  def reorder
    if @previous_order.nil?
      return
    end

    ProductCategory.where('order > ?', @prepare_for_reorder).find_each do |product_category|
      product_category.update(order: product_category.order - 1)
    end
  end
end
