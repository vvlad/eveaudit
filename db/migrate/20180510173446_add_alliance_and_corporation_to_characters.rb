class AddAllianceAndCorporationToCharacters < ActiveRecord::Migration[5.2]
  def change
    add_reference :characters, :alliance, foreign_key: true
    add_reference :characters, :corporation, foreign_key: true
  end
end
