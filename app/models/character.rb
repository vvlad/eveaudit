# frozen_string_literal: true

class Character < ApplicationRecord
  include ESI::Oauth
  belongs_to :corporation
  belongs_to :alliance, required: false
  has_many :affiliations
  has_many :corporation_memberships, -> { order(joined_at: :desc) }
  has_many :notifications

  validates :name, presence: true
  before_validation :sync, on: :create

  def sync
    character = ESI.character(character_id: id)
    assign_attributes(
      name: character.name,
      description: character.description,
      birthday: character.birthday,
      corporation: character.corporation_id && Corporation.find_or_create_by(id: character.corporation_id),
      alliance: character.alliance_id && Alliance.find_or_create_by(id: character.alliance_id)
    )
  end

  def sync!
    sync
    save!
  end
end
