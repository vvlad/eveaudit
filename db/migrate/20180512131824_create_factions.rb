class CreateFactions < ActiveRecord::Migration[5.2]
  def change
    create_table :factions do |t|
      t.string :name
      t.string :description
      t.belongs_to :corporation, foreign_key: true

      t.timestamps
    end
  end
end
