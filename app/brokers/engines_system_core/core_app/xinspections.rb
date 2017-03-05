module EnginesSystemCore
  class CoreApp
    module Inspections

      # {
      #   def active?
      #     get_boolean is_active?,
      #   def is_running?
      #     get_boolean is_running?,
      #   def reinstall_required?
      #     get_boolean rebuild_required?,
      #   def restart_required?
      #     get_boolean restart_required?,
      #   def is_error?
      #     get_boolean is_error?,
      #   def has_container?
      #     get_boolean has_container?,
      #   state:                  :read_state,
      #   container_type:         :ctype,
      #   host_name:              :hostname,
      #   http_protocol:          :http_protocol,
      #   # http_protocol_as_sym:   :protocol,
      #   # https_only?:            :https_only,
      #   domain_name:            :domain_name,
      #   default_startup_state:  :setState,
      #   memory:                 :memory,
      #   # monitored:              :monitored,
      #   framework:              :framework,
      #   runtime:                :runtime,
      #   image:                  :image,
      #   repository:             :repository,
      #   web_port:               :web_port,
      #   last_error:             :last_error,
      #   last_result:            :last_result,
      #   ps_container:           :ps_container,
      #   logs_container:         :logs_container,
      #   deployment_type:        :deployment_type
      #   web_sites:              [:web_sites, []],
      #   external_ports:         [:eports, []],
      #   environments:           [:environments, []],
      #   stats:                  [:stats, {}],
      #   volumes:                [:volumes, {}],
      #   # consumers_hash:         :consumers,
      # }.
      # each do |method, system_method_with_default|
      #   if system_method_with_default.is_a? Array
      #     system_method = system_method_with_default.first
      #     default = system_method_with_default.last
      #   else
      #     system_method = system_method_with_default
      #     default = nil
      #   end
      #   define_method(method) do
      #     CoreResult::Result.new(:get, engine_api.send(system_method), default).call # if api
      #   end
      # end

    end
  end
end
