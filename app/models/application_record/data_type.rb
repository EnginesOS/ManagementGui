class ApplicationRecord
  module DataType

    def data_type_for(method)
      if defined_enums.has_key? method.to_s
        :enum
      elsif belongs_to_names.include? method
        :belongs_to
      elsif has_one_names.include? method
        :has_one
      elsif has_many_names.include? method
        :has_many
      elsif attachment_names.include? method
        :image
      elsif data_column_names.include? method
        column_data_type_for method
      else
        :unknown_data_type
      end
    end

    private

    def attachment_names
      return [] unless respond_to? :attachment_definitions
      attachment_definitions.keys
    end

    def column_data_type_for(method)
      columns_hash[method.to_s].type.to_sym
    end

    def data_column_names
      @data_column_names ||=
        column_names.
          reject{ |column_name| belongs_to_names.
                                  include?(column_name.to_sym) }.
          reject{ |column_name| column_name == 'id' }.
          map(&:to_sym)
    end

    def belongs_to_names
      @belongs_to_names ||=
        reflect_on_all_associations(:belongs_to).
          map(&:name)
    end

    def has_one_names
      @has_one_names ||=
        reflect_on_all_associations(:has_one).map(&:name).sort
    end

    def has_many_names
      @has_many_names ||=
        reflect_on_all_associations(:has_many).map(&:name).sort
    end

  end
end
