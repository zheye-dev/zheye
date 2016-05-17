class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :content
      t.belongs_to :user
      t.belongs_to :question
      t.belongs_to :answer

      t.timestamps
    end
  end
end
