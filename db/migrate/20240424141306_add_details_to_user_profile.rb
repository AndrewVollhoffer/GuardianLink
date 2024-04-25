class AddDetailsToUserProfile < ActiveRecord::Migration[7.1]
  def change
    add_column :user_profiles, :user_id, :integer
    add_index :user_profiles, :user_id
    add_column :user_profiles, :first_name, :string
    add_column :user_profiles, :last_name, :string
    add_column :user_profiles, :hours, :integer
    add_column :user_profiles, :bio, :text
  end
end
