class AddPersonIdToForums < ActiveRecord::Migration
  def change
    add_column :forums, :person_id, :integer
    add_index :forums, :person_id
  end
end
