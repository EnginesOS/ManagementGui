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

  end
end
