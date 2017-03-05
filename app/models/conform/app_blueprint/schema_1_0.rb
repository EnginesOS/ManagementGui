module Conform
  class AppBlueprint
    class Schema_1_0

      def initialize(raw_blueprint)
        @raw_blueprint = raw_blueprint
      end

      def r(*keys)
        @raw_blueprint.dig(*keys)
      end

      def output
        { schema: {
            type: "app_blueprint",
            version: { major: 1, minor: 0 },
            origin: "Engines Developer Studio 1.0"
          },
          metadata: metadata,
          software: software
        }
      end

      def metadata
        {
          blueprint: {
            version: {
              major: r(:metadata, :blueprint, :version, :major).to_i,
              minor: r(:metadata, :blueprint, :version, :minor).to_i,
              level: r(:metadata, :blueprint, :version, :level).to_s,
              patch: r(:metadata, :blueprint, :version, :patch).to_i,
            },
            timestamp: timestamp
          },
          software: {
            display: {
              title: r(:metadata, :software, :display, :title).to_s,
              label: r(:metadata, :software, :display, :label).to_s,
              version: r(:metadata, :software, :display, :version).to_s,
              description: r(:metadata, :software, :display, :description).to_s,
              url: r(:metadata, :software, :display, :url).to_s,
            },
            license: {
              label: r(:metadata, :software, :license, :label).to_s,
              url: r(:metadata, :software, :license, :url).to_s,
            }
          }
        }
      end

      def timestamp
        DateTime.parse(r :timestamp)
      rescue
        nil
      end

      def software
        {
          base: base,
          ports: ports,
          scripts: scripts,
          external_repositories: external_repositories,
          system_packages: system_packages,
          installed_packages: installed_packages,
          required_modules: required_modules,
          service_configurations: service_configurations,
          environment_variables: environment_variables,
          template_files: template_files,
          replacement_strings: replacement_strings,
          database_seed: database_seed,
          file_write_permissions: file_write_permissions,
          persistent_directories: persistent_directories,
          persistent_files: persistent_files,
          components: components,
          workers: workers,
          rake_tasks: rake_tasks,
          custom_php_inis: custom_php_inis,
          apache_htaccess_files: apache_htaccess_files,
          apache_httpd_configurations: apache_httpd_configurations,
          actionators: actionators,
          schedules: schedules
        }
      end

      def base
        {
          name: r(:software, :base, :name).to_s,
          framework: r(:software, :base, :framework).to_s,
          memory: memory,
          http_protocol: r(:software, :base, :http_protocol).to_s,
          framework_port_override: ( r(:software, :base, :framework_port_override).present? ? r(:software, :base, :framework_port_override).to_i : '' ),
          deployment_type: r(:software, :base, :deployment_type).to_s,
          web_root_directory: r(:software, :base, :web_root_directory).to_s,
          continuous_deployment: cast_boolean_for( r(:software, :base, :continuous_deployment) ),
          install_form_comment: r(:software, :base, :install_form_comment).to_s,
          first_run_url: r(:software, :base, :first_run_url).to_s,
          installation_report: r(:software, :base, :installation_report).to_s
        }
      end

      def memory
        {
          required: r(:software, :base, :memory, :required).to_i,
          recommended: r(:software, :base, :memory, :recommended).to_i
        }
      end

      def scripts
        {
          start: { language: r(:software, :scripts, :start, :language).to_s,
                    content: r(:software, :scripts, :start, :content).to_s
                  },
          install: { language: r(:software, :scripts, :install, :language).to_s,
                    content: r(:software, :scripts, :install, :content).to_s
                  },
          post_install: { language: r(:software, :scripts, :post_install, :language).to_s,
                    content: r(:software, :scripts, :post_install, :content).to_s
                  },
          shutdown: { language: r(:software, :scripts, :shutdown, :language).to_s,
                    content: r(:software, :scripts, :shutdown, :content).to_s
                  },
        }
      end

      def database_seed
        {
          language: r(:software, :database_seed, :language).to_s,
          content: r(:software, :database_seed, :content).to_s,
          script: cast_boolean_for( r(:software, :database_seed, :script) )
        }
      end

      def components
        {
          sources: component_sources,
          path: r(:software, :components, :path).to_s,
          extract: cast_boolean_for( r(:software, :components, :extract) ),
        }
      end

      def component_sources
        ( r(:software, :components, :sources) || []).map do |c|
          component_source_for c
        end
      end

      def component_source_for(c)
        {
          label: c.dig(:label).to_s,
          url: c.dig(:url).to_s,
          install_script: {
            language: c.dig(:install_script, :language).to_s,
            content: c.dig(:install_script, :content).to_s }
        }
      end

      def service_configurations
        # byebug
        ( r(:software, :service_configurations) || []).map do |sc|
          service_configuration_for sc
        end
      end

      def service_configuration_for(sc)
        {
          publisher_namespace: sc.dig(:publisher_namespace).to_s,
          type_path: sc.dig(:type_path).to_s,
          variables: sc.dig(:variables)
        }
      end

      def persistent_directories
        ( r(:software, :persistent_directories) || []).map do |pd|
          persistent_directory_for pd
        end
      end

      def persistent_directory_for(pd)
        {
          path: pd.dig(:path).to_s
        }
      end

      def replacement_strings
        ( r(:software, :replacement_strings) || []).map do |rs|
          replacement_string_for rs
        end
      end

      def replacement_string_for(rs)
        {
          string: rs.dig(:string).to_s,
          source_file: rs.dig(:source_file).to_s,
          destination_file: rs.dig(:destination_file).to_s
        }
      end

      def persistent_files
        ( r(:software, :persistent_files) || []).map do |pf|
          persistent_file_for pf
        end
      end

      def persistent_file_for(pf)
        {
          path: pf.dig(:path).to_s
        }
      end

      def installed_packages
        ( r(:software, :installed_packages) || []).map do |ip|
          installed_package_for ip
        end
      end

      def installed_package_for(ip)
        {
          name: ip.dig(:name).to_s,
          source_url: ip.dig(:source_url).to_s,
          destination: ip.dig(:destination).to_s,
          extraction_command: ip.dig(:extraction_command).to_s,
          path_to_extracted: ip.dig(:path_to_extracted).to_s
        }
      end

      def system_packages
        ( r(:software, :system_packages) || []).map do |sp|
          system_package_for sp
        end
      end

      def system_package_for(sp)
        {
          package: sp.dig(:package).to_s,
          version: sp.dig(:version).to_s
        }
      end

      def workers
        {
          blocking: r(:software, :workers, :blocking).to_s,
          commands: worker_commands
        }
      end

      def worker_commands
        ( r(:software, :workers, :commands) || []).map do |wc|
          worker_commands_for wc
        end
      end

      def worker_commands_for(wc)
        {
          name: wc.dig(:name).to_s,
          command: wc.dig(:command).to_s
        }
      end

      def rake_tasks
        ( r(:software, :rake_tasks) || []).map do |rt|
          rake_task_for rt
        end
      end

      def rake_task_for(rt)
        {
          action: rt.dig(:action).to_s,
          always_run: cast_boolean_for( rt.dig(:always_run) )
        }
      end

      def template_files
        ( r(:software, :template_files) || []).map do |tf|
          template_file_for tf
        end
      end

      def template_file_for(tf)
        {
          path: tf.dig(:path).to_s,
          language: tf.dig(:language).to_s,
          content: tf.dig(:content).to_s
        }
      end

      def file_write_permissions
        ( r(:software, :file_write_permissions) || []).map do |fwp|
          file_write_permission_for fwp
        end
      end

      def file_write_permission_for(fwp)
        {
          path: fwp.dig(:path).to_s,
          recursive: cast_boolean_for( fwp.dig(:recursive) )
        }
      end

      def custom_php_inis
        ( r(:software, :custom_php_inis) || []).map do |cpi|
          custom_php_ini_for cpi
        end
      end

      def custom_php_ini_for(cpi)
        {
          content: cpi.dig(:content).to_s
        }
      end

      def apache_htaccess_files
        ( r(:software, :apache_htaccess_files) || []).map do |ahf|
          apache_htaccess_file_for ahf
        end
      end

      def apache_htaccess_file_for(ahf)
        {
          directory: ahf.dig(:directory).to_s,
          content: ahf.dig(:content).to_s
        }
      end

      def apache_httpd_configurations
        ( r(:software, :apache_httpd_configurations) || []).map do |ahc|
          apache_httpd_configuration_for ahc
        end
      end

      def apache_httpd_configuration_for(ahc)
        {
          content: ahc.dig(:content).to_s
        }
      end

      def required_modules
        ( r(:software, :required_modules) || []).map do |rm|
          required_module_for rm
        end
      end

      def required_module_for(rm)
        {
          name: rm.dig(:name).to_s,
          type: rm.dig(:type).to_s,
          os_package: rm.dig(:os_package).to_s
        }
      end

      def ports
        ( r(:software, :ports) || []).map do |p|
          port_for p
        end
      end

      def port_for(p)
        {
          port: p.dig(:port).to_i,
          external: p.dig(:external).to_i,
          protocol: p.dig(:protocol).to_s
        }
      end

      def actionators
        ( r(:software, :actionators) || []).map do |a|
          actionator_for a
        end
      end

      def actionator_for(a)
        {
          name: a.dig(:name).to_s,
          label: a.dig(:label).to_s,
          description: a.dig(:description).to_s,
          return_type: a.dig(:return_type).to_s,
          return_file_name: a.dig(:return_file_name).to_s,
          enable_logging: cast_boolean_for( a.dig(:enable_logging) ),
          variables: actionator_variables_for(a),
          script: {
            language: a.dig(:script, :language).to_s,
            content: a.dig(:script, :content).to_s }
        }
      end

      def actionator_variables_for(a)
        ( a.dig(:variables) || []).map do |av|
          actionator_variable_for av
        end
      end

      def actionator_variable_for(av)
        {
          name: av.dig(:name).to_s,
          value: av.dig(:value).to_s,
          mandatory: cast_boolean_for(av.dig(:mandatory)),
          input: {
            type: av.dig(:input, :type).to_s,
            label: av.dig(:input, :label).to_s,
            title: av.dig(:input, :title).to_s,
            comment: av.dig(:input, :comment).to_s,
            hint: av.dig(:input, :hint).to_s,
            placeholder: av.dig(:input, :placeholder).to_s,
            validation: {
              pattern: av.dig(:input, :validation, :pattern).to_s,
              message: av.dig(:input, :validation, :message).to_s
            },
            collection: {
              include_blank: cast_boolean_for( av.dig(:input, :collection, :include_blank) ),
              items: av.dig(:input, :collection, :items) || {}
             },
          }
        }
      end

      def external_repositories
        ( r(:software, :external_repositories) || []).map do |er|
          external_repository_for er
        end
      end

      def external_repository_for(er)
        {
          url: er.dig(:url).to_s,
          key: er.dig(:key).to_s
        }
      end

      def environment_variables
        ( r(:software, :environment_variables) || []).map do |ev|
          environment_variable_for ev
        end
      end

      def environment_variable_for(ev)
        {
          name: ev.dig(:name).to_s,
          value: ev.dig(:value).to_s,
          mandatory: cast_boolean_for(ev.dig(:mandatory)),
          immutable: cast_boolean_for(ev.dig(:immutable)),
          ask_at_build_time: cast_boolean_for(ev.dig(:ask_at_build_time)),
          build_time_only: cast_boolean_for(ev.dig(:build_time_only)),
          input: {
            type: ev.dig(:input, :type).to_s,
            label: ev.dig(:input, :label).to_s,
            title: ev.dig(:input, :title).to_s,
            comment: ev.dig(:input, :comment).to_s,
            hint: ev.dig(:input, :hint).to_s,
            placeholder: ev.dig(:input, :placeholder).to_s,
            validation: {
              pattern: ev.dig(:input, :validation, :pattern).to_s,
              message: ev.dig(:input, :validation, :message).to_s
            },
            collection: {
              include_blank: cast_boolean_for( ev.dig(:input, :collection, :include_blank) ),
              items: ev.dig(:input, :collection, :items) || {}
             },
          }
        }
      end

      def schedules
        ( r(:software, :schedules) || []).map do |s|
          schedule_for s
        end
      end

      def schedule_for(s)
        {
          label: s.dig(:label).to_s,
          timespec: {
            minute: s.dig(:timespec, :minute),
            hour: s.dig(:timespec, :hour),
            day_of_month: s.dig(:timespec, :day_of_month),
            month: s.dig(:timespec, :month),
            day_of_week: s.dig(:timespec, :day_of_week)
          },
          instruction: s.dig(:instruction).to_s,
        }.merge(
          if s.dig(:instruction).to_s == 'action'
            { actionator: schedule_actionator_for(s) }
          else
            {}
          end )
      end

      def schedule_actionator_for(s)
        {
          name: s.dig(:actionator, :name).to_s,
          params: ( s.dig(:actionator, :params) || {} )
        }
      end

      def cast_boolean_for(boolean)
        return false if boolean.nil?
        ActiveRecord::Type::Boolean.new.cast(boolean)
      end

    end
  end
end
