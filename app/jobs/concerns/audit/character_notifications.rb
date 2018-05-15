# frozen_string_literal: true

require_dependency "audit"

module Audit::CharacterNotifications
  def perform(audit)
    notifications = create_notifications(audit.character, token: audit.access_token)
    grouped_entities = notifications
                       .to_a
                       .group_by(&:sender_type)
                       .transform_values { |many| many.map(&:sender_id) }
                       .transform_keys(&:constantize)

    Affiliation.ensure_contacts(grouped_entities, character: audit.character)
    super
  end

  private

    def fetch_notifications(character, token:)
      ESI.character_notifications(character_id: character.id, token: token).map do |notification|
        {
          id: notification.notification_id,
          text: notification.text,
          sender_id: notification.sender_id,
          sender_type: notification.sender_type.classify.constantize,
          kind: notification.type,
          created_at: notification.timestamp
        }
      end
    end

    def create_notifications(character, token:)
      notifications = fetch_notifications(character, token: token)
      Notification.where(character_id: character.id).delete_all
      character.notifications.create(notifications)
    end
end
