# frozen_string_literal: true

class Notification < ApplicationRecord
  belongs_to :sender, polymorphic: true
  UNINTERESTING_KINDS = %w[
    NPCStandingsLost
    SovCommandNodeEventStarted
    SovStructureReinforced
    SovStructureDestroyed
    SovStructureSelfDestructRequested
    SovStructureSelfDestructFinished
  ].freeze

  INTERESTING_KINDS = %w[
    StructureItemsDelivered
  ].freeze
  scope :outstanding, -> { where(kind: INTERESTING_KINDS) }

  def character
    id = text.scan(/charID:\s?(\d+)/).flatten.first
    return unless id
    Character.find_or_create_by(id: id)
  end

  def character?
    character_id
  end

  def character_id
    character&.id
  end
end
