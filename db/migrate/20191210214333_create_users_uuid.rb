class CreateUsersUuid < ActiveRecord::Migration[5.1]
  def change
    create_table :users, id: :uuid do |t|
      t.text :emoji
      t.text :image
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
