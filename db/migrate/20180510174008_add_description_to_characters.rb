class AddDescriptionToCharacters < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :description, :string
    add_column :characters, :birthday, :datetime
    add_column :characters, :gender, :string
    add_column :characters, :race_id, :integer
    add_column :characters, :bloodline_id, :integer
    add_column :characters, :ancestry_id, :integer
    add_column :characters, :security_status, :float
    add_column :characters, :faction_id, :integer
  end
end
