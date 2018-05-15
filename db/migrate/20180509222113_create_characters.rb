# frozen_string_literal: true

class CreateCharacters < ActiveRecord::Migration[5.2]
  def change
    create_table :characters, id: false do |t|
      t.primary_key :id, :integer, limit: 8, default: nil
      t.string :name
      t.string :access_token
      t.string :refresh_token
      t.datetime :expires_at
      t.jsonb :granted_scopes

      t.timestamps
    end
  end
end
