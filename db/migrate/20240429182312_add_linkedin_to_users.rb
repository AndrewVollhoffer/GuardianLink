class AddLinkedinToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :linkedin, :string
  end
end
