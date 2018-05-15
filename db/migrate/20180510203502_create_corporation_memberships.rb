class CreateCorporationMemberships < ActiveRecord::Migration[5.2]
  def change
    create_table :corporation_memberships do |t|
      t.belongs_to :corporation, foreign_key: true
      t.belongs_to :character, foreign_key: true
      t.datetime :joined_at
      t.datetime :leaved_at

      t.timestamps
    end
  end
end
