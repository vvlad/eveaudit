# frozen_string_literal: true

class Affiliation < ApplicationRecord
  belongs_to :character
  belongs_to :to, polymorphic: true

  class << self
    def reflect_on(character:, contacts:)
      new_records = contacts.group_by(&:class).map do |klass, records|
        only_missing(records, klass: klass, character: character)
      end.compact.flatten
      create(new_records)
    end

    def ensure_contacts(contacts, character:)
      contacts.each do |klass, ids|
        ids.uniq!
        found = klass.where(id: ids)
        missing = ids - found.map(&:id)
        records = missing.map { |id| klass.create(id: id) } + found
        create(only_missing(records, klass: klass, character: character))
      end
    end

    def only_missing(records, klass:, character:)
      existing = where(character: character, to_type: klass.name, to_id: records.map(&:id)).pluck(:to_id)
      records
        .reject { |record| existing.include?(record.id) }
        .map { |record| { character: character, to: record } }
    end
  end
end
