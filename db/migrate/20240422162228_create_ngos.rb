class CreateNgos < ActiveRecord::Migration[7.1]
  def change
    create_table :ngos do |t|

      t.timestamps
    end
  end
end
