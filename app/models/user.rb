class User < ApplicationRecord
    has_one :user_profile

    has_secure_password

    validates_presence_of :email
    validates :email, uniqueness: true

    validates_presence_of :password
    validates :password, length: {minimum: 6}
end
