Rails.application.routes.draw do

  # mount ActionCable.server => '/cable'

  root to: 'clouds/portals#show'
  resource :bug_reports, only: [:create]

  devise_for :users, controllers: { sessions: 'users/sessions' }
  get '/sign_in', to: redirect('users/sign_in')
  namespace :user, module: :users do
    namespace :modals, module: :modals do
      resource :sign_in, only: [:show]
      resource :menu, only: [:show]
      resource :password, only: [:edit, :update]
      resource :email, only: [:edit, :update]
    end
  end

  resource :user_profile, module: :user_profiles, only: [:show] do
    resource :properties, only: [:edit, :update]
    resource :portal, only: [:show]
    resource :clouds_menu, only: [:show]
    resource :cloud, only: [:new, :create, :destroy]
  end

  resource :cloud, module: :clouds, only: [:show] do
    resource :menu, only: [:show]
    resource :properties, only: [:edit, :update]
    resource :portal, only: [:show]
    resources :libraries, except: [:show]
    resource :toggle_show_services, only: [:show]
    resource :systems_menu, only: [:show]
    resource :system, only: [:show, :new, :create, :destroy]
    resource :cloud_selection_menu, only: [:show]
  end

  namespace :system, module: :engines_systems do
    resource :sign_in, only: [:new, :create]
    resource :connection_menu, only: [:show]
    resource :connection, only: [:edit, :update]
    resource :events_stream, only: [:show]
    resource :menu, only: [:show]
    resource :control_panel, only: [:show]
    resource :properties, only: [:edit, :update]
    resource :updates, only: [:show]
    resource :report, only: [:show]
    resource :default_site, only: [:edit, :update]
    resource :default_domain, only: [:edit, :update]
    resources :domains, only: [:index]
    resource :domain, only: [:new, :create, :edit, :update, :destroy]
    resource :last_install
    resource :bug_reports, only: [:edit, :update]
    resource :admin, only: [:show]
    namespace :admin, module: :admins do
      resource :password, only: [:edit, :update]
      resource :email, only: [:edit, :update]
    end
    resources :certificates, only: [:index]
    namespace :certificate, module: :certificates do
      resource :download_ca, only: [:show]
      resource :upload, only: [:new, :create]
      resource :detail, only: [:new, :create]
      resource :download, only: [:show]
      resource :destroy, only: [:destroy]
    end
    resource :keys, only: [:show]
    namespace :key, module: :keys do
      resource :generate, only: [:show]
      resource :upload, only: [:new, :create]
      resource :download, only: [:show]
    end
    resource :activity, only: [:show] do
      resource :chart, only: [:show]
    end
    resource :service_manager, only: [:show] do
      resource :orphan_service_consumer, module: :service_managers, only: [:show, :destroy]
    end
    resource :registry, only: [:show]
    resource :logs, only: [:show]
    resource :update, only: [:show]
    resource :update_engines, only: [:show]
    resource :update_base_os, only: [:show]
    resource :restart_engines, only: [:show]
    resource :restart_base_os, only: [:show]
    resource :shutdown, only: [:new, :create]
    resource :busy, only: [:show]
  end

  namespace :app, module: :apps do
    resource :menu, only: [:show]
    resource :control_panel, only: [:show]
    resource :instruction, only: [:show]
    resources :service_consumers, only: [:index, :new]
    resource :service_consumer, module: :service_consumers do
      resource :persistent, only: [:show, :edit, :update]
      resource :persistent_share, only: [:show, :edit, :update, :destroy]
      resource :persistent_create_type, only: [:new, :create]
      resource :persistent_create, only: [:new, :create]
      resource :persistent_create_share, only: [:new, :create]
      resource :persistent_create_orphan, only: [:new, :create]
      resource :persistent_destroy, only: [:new, :create]
      resource :persistent_import, only: [:new, :create]
      resource :persistent_export, only: [:show]
      resource :persistent_subservice, only: [:new, :show, :edit, :update]
      resource :persistent_subservice_create, only: [:new, :create]
      resource :persistent_subservice_destroy, only: [:new, :create]
      resource :persistent_subservices_registration, only: [:show]
      resource :non_persistent, only: [:show, :edit, :update]
      resource :non_persistent_destroy, only: [:destroy]
      resource :non_persistent_registration, only: [:show]
      resource :non_persistent_create, only: [:new, :create]
    end
    resource :report, only: [:show]
    resource :processes, only: [:show]
    resource :about, only: [:show]
    resource :properties, only: [:edit, :update]
    resource :network, only: [:edit, :update]
    resource :memory, only: [:edit, :update]
    resource :environment, only: [:show]
    resource :environment_group, only: [:show, :edit, :update]
    resource :reinstall, only: [:show]
    resource :uninstall, only: [:new, :create]
    # resource :first_run, only: [:show]
    resource :installation_report, only: [:show]
    resource :installation_report_popup, only: [:show]
    resource :actions, only: [:show]
    resource :actionator, only: [:new, :create]
    resource :logs, only: [:show]
    resource :portal_message, only: [:show]
  end

  namespace :install, module: :installs do
    resource :precheck, only: [:show]
    resource :libraries_menu, only: [:show]
    resource :library, only: [:show]
    resource :side_load, only: [:new, :create]
    resource :repository, only: [:new]
    resource :new_app, only: [:new, :create]
    resource :build, only: [:show]
    resource :build_log, only: [:show]
    resource :build_complete, only: [:show]
  end

  namespace :service, module: :services do
    resource :menu, only: [:show]
    resource :control_panel, only: [:show]
    resource :instruction, only: [:show]
    resource :memory, only: [:edit, :update]
    # resource :variables, only: [:edit, :update]
    resource :environment, only: [:show]
    # resource :environment_group, only: [:show, :edit, :update]
    resource :report, only: [:show]
    resource :rebuild, only: [:show]
    resource :configuration, only: [:show]
    resource :configurator, only: [:edit, :update]
    resource :actions, only: [:show]
    resource :actionator, only: [:show]
    resource :logs, only: [:show]
    resource :processes, only: [:show]
    resource :restart_local_gui, only: [:show]
  end

  resource :help, only: [:show]

end
