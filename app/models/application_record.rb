class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def locale
    @locale ||= I18n.locale
  end
end
