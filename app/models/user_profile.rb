class UserProfile < ApplicationRecord
  attr_accessor :user_id

  belongs_to :user

end
