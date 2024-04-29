class AddProfileToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :hours, :integer
    add_column :users, :bio, :text
  end
end
