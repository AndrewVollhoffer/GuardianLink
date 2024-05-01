class AddNgoToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :ngo, :boolean
  end
end
