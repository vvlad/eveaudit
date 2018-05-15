# frozen_string_literal: true

require_dependency "audit"

module Audit::CharacterAffiliation
  def perform(audit)
    character = audit.character
    character.corporation_memberships.delete_all
    memberships = build_memberships(character, token: audit.access_token)
    memberships = calculate_timeduration(memberships)
    memberships.map(&:save!)
    super
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

    def build_memberships(character, token:)
      entries = ESI.character_corporation_history(character_id: character.id, token: token)
      entries.map do |history|
        character.corporation_memberships.build(
          corporation: Corporation.find_or_initialize_by(id: history.corporation_id),
          joined_at: history.start_date
        )
      end.sort_by(&:joined_at)
    end
end
