class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :crypted_password
      t.string :password_salt
      t.string :persistence_token
      t.boolean :gender
      t.string :realname
      t.date :birthday
      t.string :address
      t.string :selfIntroduction

      t.timestamps
    end
    add_index :users, :login, unique: true
  end
end
