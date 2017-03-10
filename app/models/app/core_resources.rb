class App
  module CoreResources

    def build_persistent_service_consumer(params = {})
      build_core_resource ServiceConsumer::Persistent, params
    end

    def build_persistent_service_consumer_remove(params = {})
      build_core_resource ServiceConsumer::PersistentRemove, params
    end

    def build_persistent_service_consumer_share(params = {})
      build_core_resource ServiceConsumer::PersistentShare, params
    end

    def build_non_persistent_service_consumer(params = {})
      build_core_resource ServiceConsumer::NonPersistent, params
    end

    def build_non_persistent_service_consumer_remove(params = {})
      build_core_resource ServiceConsumer::NonPersistentRemove, params
    end

    def build_persistent_service_consumer_constructor_type(params = {})
      build_core_resource ServiceConsumer::PersistentConstructorType, params
    end

    def build_persistent_service_consumer_constructor(params = {})
      build_core_resource ServiceConsumer::PersistentConstructor, params
    end

    def build_persistent_service_consumer_share_constructor(params = {})
      build_core_resource ServiceConsumer::PersistentShareConstructor, params
    end

    def build_persistent_service_consumer_orphan_constructor(params = {})
      build_core_resource ServiceConsumer::PersistentOrphanConstructor, params
    end

    def build_non_persistent_service_consumer_constructor(params = {})
      build_core_resource ServiceConsumer::NonPersistentConstructor, params
    end

    def build_persistent_service_consumer_export(params = {})
      build_core_resource ServiceConsumer::PersistentExport, params
    end

    def build_persistent_service_consumer_import(params = {})
      build_core_resource ServiceConsumer::PersistentImport, params
    end

    def build_persistent_service_consumer_subservice_consumer(params = {})
      build_core_resource ServiceConsumer::PersistentSubservice, params
    end

    def build_persistent_service_consumer_subservice_consumer_constructor(params = {})
      build_core_resource ServiceConsumer::PersistentSubserviceConstructor, params
    end

    def build_persistent_service_consumer_subservice_consumer_remove(params = {})
      build_core_resource ServiceConsumer::PersistentSubserviceRemove, params
    end

    def build_persistent_service_consumer_subservice_consumer_registration(params = {})
      build_core_resource ServiceConsumer::PersistentSubserviceRegistration, params
    end

    def build_memory(params = {})
      build_core_resource Memory, params
    end

    def build_network(params = {})
      build_core_resource Network, params
    end

    def build_environment_group(params = {})
      build_core_resource EnvironmentGroup, params
    end

    def build_actionator(params = {})
      build_core_resource Actionator, params
    end

    def build_uninstall(params = {})
      build_core_resource Uninstall, params
    end

    private

    def build_core_resource(klass, params)
      params = params.to_h.merge!({ app: self })
      klass.new params
    end

  end
end
