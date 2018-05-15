# frozen_string_literal: true

module Audit::CharacterTransactions
  def perform(audit)
    # character = audit.character
    # entries = EveOnline::ESI::CharacterWalletJournal.new(character_id: character.id, token: audit.access_token).wallet_journal_entries
    # contacts = ContactFinder.new(character: character, journal: entries).all
    # Affiliation.reflect_on(character: character, contacts: contacts)
    super
  end

  class ContactFinder
    def initialize(character:, journal:)
      @character = character
      @journal = journal
    end

    def all
      journal_entities.map do |klass, ids|
        ids.uniq!
        found = klass.where(id: ids)
        missing = ids - found.map(&:id)
        missing.map { |id| klass.create(id: id) } + found
      end.flatten
    end

    def journal_entities
      @journal
        .map { |entry| peer(entry) }
        .compact
        .group_by { |(klass, _id)| klass }
        .transform_values { |values| values.map(&:last) }
    end

    def direct_transaction?(entry)
      entry.second_party_id && entry.second_party_type
    end

    def peer(entry)
      return unless direct_transaction?(entry)
      if entry.first_party_id == @character.id && entry.first_party_type == "character"
        entity(id: entry.second_party_id, type: entry.second_party_type)
      else
        entity(id: entry.first_party_id, type: entry.first_party_type)
      end
    end

    def entity(id:, type:)
      [type.classify.constantize, id]
    end
  end
end
