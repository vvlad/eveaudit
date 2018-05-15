# frozen_string_literal: true

module ESI
  module_function

    def esi(token = nil)
      ESI::Api.new(token)
    end

    def character(character_id:)
      esi.get("/v4/characters/{character_id}/", character_id: character_id).tap do |object|
        object.birthday = Time.parse(object.birthday)
      end
    end

    def character_corporation_history(character_id:, token:)
      esi.get("/v1/characters/{character_id}/corporationhistory/",
        character_id: character_id,
        token: token).each do |entry|
        entry.start_date = Time.parse(entry.start_date)
      end
    end

    def character_notifications(character_id:, token:)
      esi.get("/v2/characters/{character_id}/notifications/",
        character_id: character_id,
        token: token).each do |entry|
        entry.timestamp = Time.parse(entry.timestamp)
      end
    end

    def corporation(corporation_id:)
      esi.get("/v4/corporations/{corporation_id}/", corporation_id: corporation_id).tap do |object|
        object.date_founded = Time.parse(object.date_founded) if object.date_founded
      end
    end

    def factions
      esi.get("/v2/universe/factions/", language: "en-us")
    end
end
