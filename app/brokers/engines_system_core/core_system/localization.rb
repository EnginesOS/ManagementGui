module EnginesSystemCore
  class CoreSystem
    module Localization

      def timezone
        get 'system/control/base_os/timezone', expect: :plain_text
      end

      def set_timezone(timezone)
        timezone = ActiveSupport::TimeZone.find_tzinfo(timezone).to_s.sub(' - ', '/')
        post 'system/control/base_os/timezone', params: {timezone: timezone}, expect: :boolean
      end

      def locale
        get 'system/control/base_os/locale', expect: :json
      end

      def set_locale(lang_code, country_code)
        post 'system/control/base_os/locale', params: {lang_code: lang_code, country_code: country_code} , expect: :boolean
      end




    end
  end
end
