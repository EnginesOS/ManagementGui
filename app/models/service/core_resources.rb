class Service
  module CoreResources

    def build_memory(params = {})
      build_core_resource Memory, params
    end

    # def build_environment(params = {})
    #   build_core_resource Environment, params
    # end

    def build_configurator(params = {})
      build_core_resource Configurator, params
    end

    def build_actionator(params = {})
      build_core_resource Actionator, params
    end

    # def build_rebuild(params = {})
    #   build_core_resource Rebuild, params
    # end

    private

    def build_core_resource(klass, params)
      params = params.to_h.merge!({ service: self })
      klass.new params
    end

  end
end
