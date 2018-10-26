class Product < ApplicationRecord
  include GCSImage

  before_save :sync_to_redis

  def initialize
    @name = {}
    @description = {}
  end

  def name
    Rails.cache.read("product:#{I18n.locale}:name")
  end

  def name=(val)
    @name[@locale] = val
  end

  def description
    Rails.cache.read("product:#{I18n.locale}")
  end

  def description=
    @description[@locale] = val
  end

  private
  def sync_to_redis
    unless @name.blank?
      @name.each do |locale, value|
        Rails.cache.write("product:#{locale}:name", value)
      end
    end

    unless @description.blank?
      @description.each do |locale, value|
        Rails.cache.write("product:#{locale}:description", value)
      end
    end

    # Reset the cached variable
    @name = {}
    @description = {}
  end
end
