class Install
  class SideLoad

    include ActiveModel::Model

    attr_accessor :repository_url

    validates :repository_url, presence: true

    def install_metadata
      { schema: '0.1', data: { method: :gui_side_load } }
    end

  end
end
