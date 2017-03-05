module EnginesRepositories
  class Blueprint

    def initialize(url)
      @url = url
    end

    def blueprint
      JSON.parse(raw_blueprint, symbolize_names: true)
    rescue JSON::ParserError
      raise EnginesRepositoryParseError
    end

    def raw_blueprint
      if is_git_repo?
        clone_blueprint
      else
        get_blueprint
      end
    end

    private

    def get_blueprint
      Rails.logger.info "Engines installer get blueprint."
      RestClient.get(@url)
    rescue URI::InvalidURIError => e
      Rails.logger.warn "Engines installer get blueprint failed: #{e.class}"
      raise EnginesRepositoryUrlError
    end

    def clone_blueprint
      Rails.logger.info "Engines installer clone blueprint."
      clear_exisiting_clone
      Git.clone @url, 'engines_installer_blueprint', path: clone_dir, depth: 1
      File.read cloned_blueprint_path
    rescue URI::InvalidURIError => e
      Rails.logger.warn "Engines installer clone blueprint failed: #{e}"
      raise EnginesRepositoryUrlError
    end

    def is_git_repo?
      Git.ls_remote(@url).present?
    rescue
      false
    end

    def clone_dir
      Rails.application.config.tmp_dir
    end

    def cloned_blueprint_dir
      "#{clone_dir}/engines_installer_blueprint"
    end

    def cloned_blueprint_path
      "#{clone_dir}/engines_installer_blueprint/blueprint.json"
    end

    def clear_exisiting_clone
      FileUtils.rm_rf "#{clone_dir}/engines_installer_blueprint"
    end


  end
end
