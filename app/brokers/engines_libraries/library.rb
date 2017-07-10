module EnginesLibraries
  class Library

    def initialize(opts)
      @name = opts[:name]
      @url = opts[:url]
    end

    attr_reader :name, :url

    def apps
      return schema_0_1_apps if apps_hash[:schema] == '0.1'
      schema_0_apps
    end

    def schema_0_1_apps
      apps_hash[:apps].map do |app|
        {
          install_metadata: { schema: '0.1', data: { method: :gui_library, library_schema: '0.1', app: app } },
          repository_url: app[:blueprint_url],
          label: app[:label],
          icon_url: app[:icon_url_small]
        }
      end
    end

    def schema_0_apps
      apps_hash[:softwares].map do |app|
        {
          install_metadata: { schema: '0.1', data: { method: :gui_library, library_schema: '0', app: app } },
          repository_url: app[:repository_url],
          label: app[:label],
          icon_url: app[:icon_url]
        }
      end
    end

    def apps_hash
      @apps_hash ||= parse_apps_json(apps_json)
    end

    def parse_apps_json(json)
      JSON.parse(json).deep_symbolize_keys
    rescue => e
      Rails.logger.debug "Engines library #{@url} parse apps json failed: #{e}"
      raise EnginesError.new "Library error. Failed to parse json from Engines library at #{@url}. #{e}"
    end

    def apps_json
      RestClient::Request.execute(method: :get, url: @url, verify_ssl: false, payload: {per_page: 1000})
    rescue => e
      Rails.logger.debug "Engines library #{@url} get apps call failed: #{e}"
      raise EnginesError.new "Library error. Failed to get apps from Engines library at #{@url}. #{e}"
    end

  end
end
