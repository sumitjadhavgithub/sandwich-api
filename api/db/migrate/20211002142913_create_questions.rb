class CreateQuestions < ActiveRecord::Migration[5.0]
  def change
    create_table :questions do |t|
      t.string :name
      t.integer :user_id
      t.timestamps
    end
  end
end
