class AddScoreToUsers < ActiveRecord::Migration
  def change
    add_column :users, :score, :Float
  end
end
