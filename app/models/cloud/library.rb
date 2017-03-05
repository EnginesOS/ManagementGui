class Cloud
  class Library < ApplicationRecord

    belongs_to :cloud

    # self.table_name = :system_libraries


#     def self.find(*args)
#
# p :find_args
# p args
#
#       return engines_library if args = :engines_library
#       super
#     end

    def apps
      EnginesLibraries::Library.new(name: name, url: url).apps.sort_by{|app| app[:name]}
    end

    def to_s
      name
    end

  end
end
