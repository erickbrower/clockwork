class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :twitter_handle
      t.text :bio
      t.date :birthdate
      t.integer :person_id

      t.timestamps
    end
  end
end
