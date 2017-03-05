class Cloud
  class App < ApplicationRecord

    belongs_to :cloud
    belongs_to :app

  end
end
