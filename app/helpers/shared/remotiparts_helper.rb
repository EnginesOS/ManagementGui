module Shared
  module RemotipartsHelper

    def j(html)
      return super "#{html}" if remotipart_submitted?
      super html
    end

  end
end
