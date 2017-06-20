class EnginesSystem
  module Status

    def system_status
      @system_status ||= core_system.system_status
    end

    def builder_status
      @builder_status ||= core_system.builder_status
    end

    def building?
      builder_status[:is_building]
    end

    def build_failed?
      builder_status[:did_build_fail]
    end

    def is_rebooting?
      system_status[:is_rebooting]
    end

    def is_base_system_updating?
      system_status[:is_base_system_updating]
    end

    def is_engines_system_updating?
      system_status[:is_engines_system_updating]
    end

    def needs
      [ ( 'Update base OS' if system_status[:needs_base_update] ),
        ( 'Update Engines' if system_status[:needs_engines_update] ),
        ( 'Reboot' if system_status[:needs_reboot] ) ].compact
    end

  end
end
