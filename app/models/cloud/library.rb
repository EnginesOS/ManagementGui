class Cloud
  class Library < ApplicationRecord

    belongs_to :cloud

    def apps
      EnginesLibraries::Library.new(name: name, url: url).apps.sort_by{|app| app[:name]}
    end

    def to_s
      name
    end

  end
end
