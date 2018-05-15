class MoveCredentialsFromCharactersToAudits < ActiveRecord::Migration[5.2]
  def change
    remove_columns :characters, :access_token, :refresh_token, :expires_at

    change_table :audits do |t|
      t.string :access_token
      t.string :refresh_token
      t.datetime :expires_at
    end
  end
end
