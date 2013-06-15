class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.text :about
      t.text :hobbies
      t.text :job
      t.references :user

      t.timestamps
    end
    add_index :profiles, :user_id
  end
end
