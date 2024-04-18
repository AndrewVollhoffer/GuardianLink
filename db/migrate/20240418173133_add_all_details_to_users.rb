class AddAllDetailsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :last_name, :string
    add_column :users, :email, :string
    add_column :users, :password, :string
    add_column :users, :bio, :text
  end
end
