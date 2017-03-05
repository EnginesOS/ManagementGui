class ApplicationRecord
  module ImageClass

    def has_image(method, sizes=default_image_sizes)
      has_attached_file method, dependent: :destroy,
      styles:
        { small: sizes.first, medium: sizes.second, large: sizes.third }
      validates_attachment_content_type method, :content_type => /\Aimage\/.*\Z/
      attr_accessor "#{method}_clear"
      before_validation :check_clear_attachment_for, method
    end

    def default_image_sizes
      [ "64x64>", "128x128>", "256x256>" ]
    end

  end
end
