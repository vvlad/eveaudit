class AddFieldsToCorporations < ActiveRecord::Migration[5.2]
  def change
    add_column :corporations, :member_count, :string
    add_column :corporations, :tax_rate, :string
    add_column :corporations, :date_founded, :date
    add_column :corporations, :ceo_id, :integer, limit: 8
    add_column :corporations, :creator_id, :string
    add_column :corporations, :corporation_url, :string
    add_column :corporations, :faction_id, :string
    add_column :corporations, :home_station_id, :string
    add_column :corporations, :shares, :integer, limit: 8
  end
end
