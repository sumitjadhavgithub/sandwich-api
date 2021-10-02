class AddDoorkeeperClient < ActiveRecord::Migration[5.0]
  def change
    execute <<-SQL
    INSERT INTO oauth_applications(name, uid, secret, redirect_uri, scopes, confidential, created_at, updated_at)
    VALUES('webapp', 'TQXWDJYJZUELOTSGILGBKUAQQLNEIKDJDJIZ', 'HRBNMSARWRTCACKOKMRNQWVNDFFDUHGLWTAMYRWH', '', '', false, now(), now());
    SQL
  end
end
