class CreateWebSockets < ActiveRecord::Migration[5.0]
  def change
    create_table :web_sockets do |t|
      t.integer :user_id, null: false
      t.string :uuid, null: false
      t.string :channel_type, null: false, unique: true
      t.timestamps
    end
  end
end
