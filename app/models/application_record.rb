class ApplicationRecord < ActiveRecord::Base

  extend ImageClass
  include ImageInstance
  extend DataType
  extend CustomAttributeLabels

  self.abstract_class = true

  def to_s
    "#{self.class.name.humanize} #{id}"
  end

end
