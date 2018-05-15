class CreateAffiliations < ActiveRecord::Migration[5.2]
  def change
    create_table :affiliations do |t|
      t.belongs_to :character, foreign_key: true
      t.belongs_to :to, polymorphic: true

      t.timestamps
    end
  end
end
