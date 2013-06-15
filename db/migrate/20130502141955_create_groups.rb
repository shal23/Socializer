class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.text :owner
     t.text :description

      t.timestamps
    end
   # add_index :groups, :user_id
    #add_index :groups, :profile_id
  end
end
