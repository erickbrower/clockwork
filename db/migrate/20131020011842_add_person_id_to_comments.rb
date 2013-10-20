class AddPersonIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :person_id, :integer
    add_index :comments, :person_id
  end
end
