class Service
  module Properties

    def websites
      @websites ||= core_service.websites
    end

  # configurations

  def configurations
    @configurations ||= core_service.configurations
  end

  def configurators
    @configurators ||= service_definition[:configurators]
  end

  # actions

  def actionators
    @actionators ||= core_service.actionators
  end

  def actionator_for(actionator_name)
    core_service.actionator_for(actionator_name)
  end

  # environment variables

  def environment_variables
    @environment_variables ||= container[:environments]
  end

  # memory

    def memory
      @memory ||= container[:memory]
    end

    def minimum_memory
      @minimum_memory ||= service_definition[:required_memory] || 0
    end

    def recommended_memory
      @recommended_memory ||= service_definition[:recommended_memory] || 0
    end

  # network

    def network_http_protocol
      @network_http_protocol ||= container[:protocol]
    end

    def network_host_name
      @network_host_name ||= container[:hostname]
    end

    def network_domain
      @network_domain ||= container[:domain_name]
    end


  # # first_run
  #
  #   def first_run_url
  #     @first_run_url ||= resolved_first_run_url
  #   end
  #
  #   def resolved_first_run_url
  #     core_app.resolve_string(blueprint[:first_run_url]) if blueprint[:first_run_url].present?
  #   end
  #
  # # services
  #
  # def persistent_services
  #   @persistent_services ||= core_app.persistent_services.sort_by{ |service| service[:container_name] }
  # end
  #
  # def non_persistent_services
  #   @non_persistent_services ||= core_app.non_persistent_services.sort_by{ |service| service[:container_name] }
  # end



  end
end
