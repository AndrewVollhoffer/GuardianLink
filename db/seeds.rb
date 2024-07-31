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
    # Admin
    User.create(
      :email=>"admin@guardianlink.com",
      :password=>"password",
      :password_confirmation=>"password",
      :admin=>true)

    # Users
    User.create(
      :email=>"buddy@email.com",
      :password=>"buddy123",
      :password_confirmation=>"buddy123")

    User.create(
      :email=>"guardfan@email.com",
      :password=>"guardfan123",
      :password_confirmation=>"guardfan123")

    User.create(
      :email=>"haha@email.com",
      :password=>"haha123",
      :password_confirmation=>"haha123")

    # Organizations
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
    # Admin
    User.create(
      :email=>"admin@guardianlink.com",
      :password=>ENV.fetch("ADMIN_PASSWORD"),
      :password_confirmation=>ENV.fetch("ADMIN_PASSWORD"),
      :admin=>true)

    # Users
    User.create(
      :email=>"JohnDoe@email.com",
      :password=>"johndoe123",
      :password_confirmation=>"johndoe123",
      :first_name=>"John",
      :last_name=>"Doe",
      :hours=>10,
      :linkedin=>"iamawesome.com",
      :bio=>"I am John Doe. I am a software engineer.")

    User.create(
      :email=>"guardfan@email.com",
      :password=>"guardfan123",
      :password_confirmation=>"guardfan123",
      :first_name=>"Guardiest",
      :last_name=>"Fanniest",
      :hours=>60,
      :linkedin=>"iamawesome.com",
      :bio=>"I am Guardiest Fanniest and I am the biggest fan of GuardianLink. I am not a software engineer,
        but I am a fan of the GuardianLink team and I think that counts.")

    User.create(
      :email=>"JaneDoe@email.com",
      :password=>"janedoe123",
      :password_confirmation=>"janedoe123",
      :first_name=>"Jane",
      :last_name=>"Doe",
      :hours=>2,
      :linkedin=>"iamawesome.com",
      :bio=>"I am Jane Doe. I am the wife of John Doe and I handle all of his paperwork. Even though I do his paperwork
        he does the dishes so I think that's fair.")

      User.create(
        :email=>"Maximus@email.com",
        :password=>"maximus123",
        :password_confirmation=>"maximus123",
        :first_name=>"Maximus",
        :last_name=>"Meridius",
        :hours=>35,
        :linkedin=>"iamawesome.com",
        :bio=>"My name is Maximus Decimus Meridius, Commander of the Armies of the North, General of the Felix Legions,
          loyal servant to the true emperor, Marcus Aurelius. Father to a murdered son, husband to a murdered wife.
          And I will have my vengeance, in this life or the next")

      User.create(
        :email=>"chaosman@email.com",
        :password=>"chaosman123",
        :password_confirmation=>"chaosman123",
        :first_name=>"Diederick",
        :last_name=>"Kastner",
        :hours=>1,
        :linkedin=>"iamawesome.com",
        :bio=>"So soon the hour of fate comes around. The Everchosen stirs from his dark throne and prepares the blow
          that shall split the world asunder. Realms of old have fallen, lost beneath the fury of the northlands,
          or smothered by vermin from below. Some heroes battle on, too stubborn to realise all hope is lost.
          Their time is past, and a new age of Chaos and dismay beckons. Perhaps I am foolish also, for I fight with
          no hope of victory. I seek only to weaken the Dark Gods, to shake their hold upon the future. No other
          course remains; not to mortals, nor the Divine.")

      User.create(
        :email=>"Marcus@email.com",
        :password=>"marcus123",
        :password_confirmation=>"marcus123",
        :first_name=>"Marcus",
        :last_name=>"Aurelius",
        :hours=>40,
        :linkedin=>"iamawesome.com",
        :bio=>"You have power over your mind - not outside events. Realize this, and you will find strength.
          Dwell on the beauty of life. Watch the stars, and see yourself running with them.
          The happiness of your life depends upon the quality of your thoughts.
          The more you love them, the more they will follow you - always.
          The more you like them, the more they will take you everywhere.
          The more you are loved, the more they will give you - always.")

      User.create(
        :email=>"Felix@email.com",
        :password=>"felix123",
        :password_confirmation=>"felix123",
        :first_name=>"Felix",
        :last_name=>"Legion",
        :hours=>50,
        :linkedin=>"iamawesome.com",
        :bio=>"The Legion of Doom, also known as the Legion of the Dead, is a fictional military organization")

    # Organizations
    User.create(
      :email=>"biz@email.com",
      :password=>"biz123",
      :password_confirmation=>"biz123",
      :first_name=>"Business Business Inc",
      :bio=>"Too much business could be not enough business if business is not busy enough. lol what autocomplete?",
      :ngo=>true)

    User.create(
      :email=>"cityone@email.com",
      :password=>"cityone123",
      :password_confirmation=>"cityone123",
      :first_name=>"City One LLC",
      :bio=>"City One is the best. Even better than Business Business Inc and New Busy. Come work for us and we'll pay
        you under the table.",
      :ngo=>true)

    User.create(
      :email=>"newbusy@email.com",
      :password=>"newbusy123",
      :password_confirmation=>"newbusy123",
      :first_name=>"New Busy Corp",
      :bio=>"New Busy is the best. Even better than City One. Come work for us and we'll pay you above the table and
        even help you redo your resume.",
      :ngo=>true)

    User.create(
      :email=>"toomuchadmin@email.com",
      :password=>"toomuchadmin123",
      :password_confirmation=>"toomuchadmin123",
      :first_name=>"Too Much Admin .Com",
      :bio=>"If you're too much. You're too much. You're too much. You're too much. You're too much. You're too much.
        Autocomplete AI is your friend (and your enemy). It literally said both things lol.",
      :ngo=>true)
end
