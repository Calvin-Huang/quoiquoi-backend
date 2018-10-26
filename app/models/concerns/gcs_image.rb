module GCSImage
  extend ActiveSupport::Concern

  def included
    @image_bag = { create: [], delete: [], update: [] }
  end

  def images
    Image.where(ref: "#{self.class.to_s.underscore}:#{read_attribute(:id)}").order(:order) || []
  end
end