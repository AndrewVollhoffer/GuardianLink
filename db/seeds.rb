# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

case Rails.env
  when "development"
    User.create(
      :email=>"admin@guardianlink.com",
      :password=>"1guardianlinkadmin1",
      :password_confirmation=>"1guardianlinkadmin1",
      :admin=>true)

    User.create(
      :email=>"test@email.com",
      :password=>"test123",
      :password_confirmation=>"test123")

    User.create(
      :email=>"guardfan@email.com",
      :password=>"guardfan123",
      :password_confirmation=>"guardfan123")

    User.create(
      :email=>"test@email.com",
      :password=>"test123",
      :password_confirmation=>"test123")

    User.create(
      :email=>"bizt@email.com",
      :password=>"biz123",
      :password_confirmation=>"biz123",
      :ngo=>true)

    User.create(
      :email=>"cityone@email.com",
      :password=>"cityone123",
      :password_confirmation=>"cityone123",
      :ngo=>true)

    User.create(
      :email=>"newbusy@email.com",
      :password=>"newbusy123",
      :password_confirmation=>"newbusy123",
      :ngo=>true)

  when "production"
    User.create(
      :email=>"admin@guardianlink.com",
      :password=>"1guardianlinkadmin1",
      :password_confirmation=>"1guardianlinkadmin1",
      :admin=>true)

    User.create(
      :email=>"test@email.com",
      :password=>"test123",
      :password_confirmation=>"test123")

    User.create(
      :email=>"guardfan@email.com",
      :password=>"guardfan123",
      :password_confirmation=>"guardfan123")

    User.create(
      :email=>"test@email.com",
      :password=>"test123",
      :password_confirmation=>"test123")

    User.create(
      :email=>"bizt@email.com",
      :password=>"biz123",
      :password_confirmation=>"biz123",
      :ngo=>true)

    User.create(
      :email=>"cityone@email.com",
      :password=>"cityone123",
      :password_confirmation=>"cityone123",
      :ngo=>true)

    User.create(
      :email=>"newbusy@email.com",
      :password=>"newbusy123",
      :password_confirmation=>"newbusy123",
      :ngo=>true)
end
