class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
        t.integer :attitude
        t.string :type
        t.belongs_to :user
        t.belongs_to :question
        t.belongs_to :answer

        t.timestamps
    end
  end
end
