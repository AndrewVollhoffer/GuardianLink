class User < ApplicationRecord

    attr_accessor :signed_in

    has_secure_password
    has_one_attached :profile_photo

    validates_presence_of :email
    validates :email, uniqueness: true

    validates_presence_of :password, on: :create
    validates :password, length: {minimum: 6}, unless: :signed_in

    validate :valid_image

    # Checks for the proper file type and size
    def valid_image
        return unless profile_photo.attached?

        unless profile_photo.blob.byte_size <= 1.megabyte
            errors.add(:profile_photo, "Image must be less than 1MB")
        end
        unless profile_photo.blob.content_type == ".jpg" || profile_photo.blob.content_type == "png"
            errors.add(:profile_photo, "Image must a jpeg or png")
        end
    end

end
