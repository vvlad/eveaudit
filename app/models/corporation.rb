# frozen_string_literal: true

class Corporation < ApplicationRecord
  belongs_to :alliance, required: false
  belongs_to :ceo, class_name: "Character", required: false

  before_create :sync

  SYNC_ATTRIBUTES = %i[
    name
    ticker
    member_count
    ceo_id
    description
    tax_rate
    date_founded
    creator_id
    corporation_url
    faction_id
    home_station_id
    shares
  ].freeze

  def sync
    esi = ESI.corporation(corporation_id: id)
    attrs = esi.to_h.with_indifferent_access.slice(*SYNC_ATTRIBUTES)
    if esi.alliance_id
      attrs[:alliance] = Alliance.find_or_initialize_by(id: esi.alliance_id)
    end
    attrs[:ceo] = Character.find_or_initialize_by(id: esi.ceo_id)
    update_attributes!(attrs) unless new_record?
  end
end
