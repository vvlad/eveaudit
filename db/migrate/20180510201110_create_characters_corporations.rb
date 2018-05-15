class CreateCharactersCorporations < ActiveRecord::Migration[5.2]
  def change
    create_table :characters_corporations, id: false do |t|
      t.belongs_to :corporation
      t.belongs_to :character
    end
  end
end
