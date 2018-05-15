# frozen_string_literal: true

class CharacterAffiliationJob < ApplicationJob
  queue_as :default

  def perform(character)
    Character.transaction do
      character.corporation_memberships.delete_all
      memberships = build_memberships(character)
      memberships = calculate_timeduration(memberships)
      memberships.map(&:save!)
    end
  end

  private

    def calculate_timeduration(memberships)
      memberships.each_with_index do |membership, index|
        new = memberships[index + 1]
        next unless new
        membership.leaved_at = new.joined_at
      end
      memberships
    end

    def build_memberships(character)
      api = EveOnline::ESI::CharacterCorporationHistory.new(character_id: character.id, token: character.access_token)
      api.corporation_history.map do |history|
        character.corporation_memberships.build(
          corporation: Corporation.find_or_initialize_by(id: history.corporation_id),
          joined_at: history.start_date
        )
      end.sort_by(&:joined_at)
    end
end
