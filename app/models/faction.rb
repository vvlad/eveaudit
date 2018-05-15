# frozen_string_literal: true

class Faction < ApplicationRecord
  include ESISyncing
  belongs_to :corporation, required: false

  def self.sync!
    ESI.factions.each do |faction|
      corporation = Corporation.find_or_initialize_by(id: faction.corporation_id) if faction.corporation_id

      find_or_initialize_by(id: faction.faction_id)
        .update_attributes!(
          name: faction.name,
          description: faction.description,
          corporation: corporation
        )
    end
  end
end
