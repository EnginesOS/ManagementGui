module Conform
  class AppBlueprint
    class Schema_0_0ToSchema_1_0

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
              major: r(:software, :major).to_i,
              minor: r(:software, :minor).to_i,
              level: r(:software, :release_level).to_s.sub('Release candidate', 'rc').sub('Beta', 'beta').gsub('Alpha', 'alpha'),
              patch: r(:software, :patch).to_i,
            },
            timestamp: nil
          },
          software: {
            display: {
              title: r(:software, :full_title).to_s,
              label: r(:software, :short_title).to_s,
              version: '',
              description: r(:software, :description).to_s,
              url: r(:software, :home_page_url).to_s,
            },
            license: {
              label: r(:software, :license_label).to_s,
              url: r(:software, :license_sourceurl).to_s,
            }
          }
        }
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
          schedules: []
        }
      end

      def base
        {
          name: r(:software, :name).to_s,
          framework: r(:software, :framework).to_s,
          memory: memory,
          http_protocol: r(:software, :http_protocol).to_s,
          framework_port_override: ( r(:software, :framework_port_override).present? ? r(:software, :framework_port_override).to_i : '' ) ,
          deployment_type: r(:software, :deployment_type).to_s,
          web_root_directory: r(:software, :web_root_directory).to_s,
          continuous_deployment: cast_boolean_for( r(:software, :continuous_deployment) ),
          install_form_comment: '',
          first_run_url: r(:software, :first_run_url).to_s,
          installation_report: r(:software, :installation_report_template).to_s
        }
      end

      def memory
        {
          required: r(:software, :required_memory).to_i,
          recommended: r(:software, :recommended_memory).to_i
        }
      end

      def scripts
        {
          start: {
            language: :sh,
            content: r(:software, :custom_start_script).to_s
          },
          install: {
            language: :sh,
            content: r(:software, :custom_install_script).to_s
          },
          post_install: {
            language: :sh,
            content: r(:software, :custom_post_install_script).to_s
          },
          shutdown: {
            language: :sh,
            content: ''
          },
        }
      end

      def database_seed
        {
          language: :text,
          content: r(:software, :database_seed_file).to_s,
          script: false
        }
      end

      def components
        {
          sources: component_sources,
          path: r(:software, :component_path).to_s,
          extract: cast_boolean_for( r(:software, :extract_components) ),
        }
      end

      def component_sources
        ( r(:software, :component_sources) || []).map do |c|
          component_source_for c
        end
      end

      def component_source_for(c)
        {
          label: '',
          url: c.dig(:url).to_s,
          install_script: {
            language: :sh,
            content: '' }
        }
      end

      def service_configurations
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
          string: rs.dig(:replacement_string).to_s,
          source_file: rs.dig(:file).to_s,
          destination_file: rs.dig(:destination).to_s
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
          version: ''
        }
      end

      def workers
        {
          blocking: r(:software, :blocking_worker_name).to_s,
          commands: worker_commands
        }
      end

      def worker_commands
        ( r(:software, :workers) || []).map do |wc|
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
          always_run: cast_boolean_for(rt.dig(:always_run))
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
          language: :text,
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
          recursive: cast_boolean_for(fwp.dig(:recursive))
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
          content: ahf.dig(:htaccess_content).to_s
        }
      end

      def apache_httpd_configurations
        ( r(:software, :apache_httpd_configurations) || []).map do |ahc|
          apache_httpd_configuration_for ahc
        end
      end

      def apache_httpd_configuration_for(ahc)
        {
          content: ahc.dig(:httpd_configuration).to_s
        }
      end

      def required_modules
        ( r(:software, :modules) || []).map do |rm|
          required_module_for rm
        end
      end

      def required_module_for(rm)
        {
          name: rm.dig(:module_name).to_s,
          type: rm.dig(:module_type).to_s,
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
        ( r(:software, :actionators) || {}).map do |key, a|
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
          enable_logging: cast_boolean_for(a.dig(:log)),
          variables: actionator_variables_for(a),
          script: {
            language: :sh,
            content: a.dig(:script).to_s },
        }
      end

      def actionator_variables_for(a)
        ( a.dig(:params) || {}).map do |key, av|
          actionator_variable_for av
        end
      end

      def actionator_variable_for(av)
        {
          name: av.dig(:name).to_s,
          value: av.dig(:value).to_s,
          mandatory: cast_boolean_for(av.dig(:mandatory)),
          input: {
            type: variable_field_type_for(av),
            label: av.dig(:label).to_s,
            title: av.dig(:tooltip).to_s,
            comment: av.dig(:input, :comment).to_s,
            hint: av.dig(:hint).to_s,
            placeholder: av.dig(:placeholder).to_s,
            validation: {
              pattern: av.dig(:regex_validator).to_s,
              message: av.dig(:regex_invalid_message).to_s
            },
            collection: {
              include_blank: false,
              items: variable_collection_items_for(av)
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
          url: er.dig(:repository).to_s,
          key: ''
        }
      end

      def environment_variables
        ( r(:software, :variables) || []).map do |ev|
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
            type: variable_field_type_for(ev),
            label: ev.dig(:label).to_s,
            title: ev.dig(:tooltip).to_s,
            comment: ev.dig(:input, :comment).to_s,
            hint: ev.dig(:hint).to_s,
            placeholder: ev.dig(:placeholder).to_s,
            validation: {
              pattern: ev.dig(:regex_validator).to_s,
              message: ev.dig(:regex_invalid_message).to_s
            },
            collection: {
              include_blank: false,
              items: variable_collection_items_for(ev)
             },
          }
        }
      end

      def variable_collection_items_for(variable)
        vsc = variable.dig(:select_collection)
        return {} if vsc.empty?
        # case vsc
        # when String
        #   vsc.split ' '
        # else
        #   vsc
        # #
        # #    || {}

        # byebug

        vsc



      end

      def variable_field_type_for(v)
        case v.dig(:field_type).to_sym
        when :boolean
          :boolean
        when :collection, :select, :select_single
          :select
        when :int
          :integer
        when :hidden
          :hidden
        when :password
          :password
        when :password_with_confirmation
          :password_with_confirmation
        when :text, :text_area
          :text
        when :text_field
          :string
        end
      end

      def cast_boolean_for(boolean)
        return false if boolean.nil?
        ActiveRecord::Type::Boolean.new.cast(boolean)
      end

    end
  end
end
