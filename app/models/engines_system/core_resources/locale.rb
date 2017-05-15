class EnginesSystem
  module CoreResources
    class Locale

      include ActiveModel::Model

      attr_accessor  :engines_system
      attr_writer :language, :country

      def locale_parameters
        @locale_parameters ||= core_system.locale
      end

      def language
        @language ||= locale_parameters[:lang_code]
      end

      def country
        @country ||= locale_parameters[:country_code]
      end

      def new_record?
        false
      end

      def update_system
        core_system.set_locale @language, @country
      end

      def core_system
        engines_system.core_system
      end


    end
  end
end
