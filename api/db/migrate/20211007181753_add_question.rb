class AddQuestion < ActiveRecord::Migration[5.0]
  def change
    execute <<-SQL
      INSERT INTO questions(name, user_id, created_at, updated_at)
      VALUES('Is a hot dog a sandwich? Why?', (select id from users limit 1), now(), now());
    SQL
  end
end
