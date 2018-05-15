class CorporationMembership < ApplicationRecord
  belongs_to :corporation
  belongs_to :character

  delegate :name, :ticker, to: :corporation
end
