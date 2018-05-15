# frozen_string_literal: true

class Audit < ApplicationRecord
  belongs_to :character

  validates :access_token, presence: true

  before_validation :generate_key, on: :create

  after_create :enqueue_job

  def generate_key
    self.key = SecureRandom.urlsafe_base64
  end

  def enqueue_job
    AuditJob.perform_later(self)
  end

  class AccessTokenExpiredError < RuntimeError
  end

end
