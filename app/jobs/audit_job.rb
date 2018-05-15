# frozen_string_literal: true

class AuditJob < ApplicationJob
  queue_as :default
  include Audit::CharacterAffiliation
  include Audit::CharacterNotifications
  include Audit::CharacterMails
  include Audit::CharacterTransactions
end
