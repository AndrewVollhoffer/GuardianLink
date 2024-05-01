class User < ApplicationRecord

    has_secure_password
    has_one_attached :profile_photo

    validates_presence_of :email
    validates :email, uniqueness: true

    validates_presence_of :password
    validates :password, length: {minimum: 6}

    validate :valid_image

    def valid_image
        return unless profile_photo.attached?

        unless profile_photo.blob.byte_size <= 1.megabyte
            errors.add(:profile_photo, "Image must be less than 1MB!")
        end
        unless profile_photo.blob.content_type == ".jpg" || profile_photo.blob.content_type == "png"
            errors.add(:profile_photo, "Image must be less than 1MB!")
        end
    end
end
