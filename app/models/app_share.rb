class AppShare < ApplicationRecord

    belongs_to :app
    belongs_to :user_profile

end
