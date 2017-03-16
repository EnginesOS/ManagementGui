class App
  module ServiceConsumers

    def persistent_service_consumers
      @persistent_service_consumers ||=
      persistent_services.select do |service|
        service[:shared] != true
      end.map do |service|
        build_persistent_service_consumer(
          publisher_type_path: "#{service[:publisher_namespace]}/#{service[:type_path]}",
          service_handle: service[:service_handle] )
      end
    end

    def persistent_service_consumer_shares
      @persistent_service_consumer_shares ||=
      persistent_services.select do |service|
        service[:shared] == true
      end.map do |service|
        
        build_persistent_service_consumer_share(
          parent_engine: service[:parent_engine],
          publisher_type_path: "#{service[:publisher_namespace]}/#{service[:type_path]}",
          service_handle: service[:service_handle] )
      end
    end

    def non_persistent_service_consumers
      @non_persistent_service_consumers ||=
      non_persistent_services.map do |service|
        build_non_persistent_service_consumer(
          publisher_type_path: "#{service[:publisher_namespace]}/#{service[:type_path]}",
          service_handle: service[:service_handle] )
      end
    end

    def persistent_service_consumer_constructors
      @persistent_service_consumer_constructors ||=
      available_persistent_services.map do |service|
        build_persistent_service_consumer_constructor(
          publisher_type_path: "#{service[:publisher_namespace]}/#{service[:type_path]}" )
      end
    end

    def non_persistent_service_consumer_constructors
      @non_persistent_service_consumer_constructors ||=
      available_non_persistent_services.map do |service|
        build_non_persistent_service_consumer_constructor(
          publisher_type_path: "#{service[:publisher_namespace]}/#{service[:type_path]}" )
      end
    end

  end
end
