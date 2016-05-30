class AddScoreToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :score, :float
  end
end
