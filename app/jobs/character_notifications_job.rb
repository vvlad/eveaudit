# frozen_string_literal: true

class CharacterNotificationsJob < ApplicationJob
  queue_as :default

  def perform(character)
    notifications = fetch_notifications(character)
    Character.transaction do
      Notification.where(character_id: character.id).delete_all
      character.notifications.create(notifications)
    end
  end

  private

    def fetch_notifications(character)
      EveOnline::ESI::CharacterNotifications.new(character_id: character.id, token: character.access_token).notifications.map do |notification|
        {
          id: notification.notification_id,
          text: notification.text,
          sender_id: notification.sender_id,
          sender_type: notification.sender_type.classify,
          kind: notification.type,
          created_at: notification.timestamp
        }
      end
    end
end
