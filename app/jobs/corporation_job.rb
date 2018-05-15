# frozen_string_literal: true

class CorporationJob < ApplicationJob
  queue_as :default
  include EsiJob

  ATTRIBUTES = %i[
    name
    ticker
    member_count
    ceo_id
    description
    tax_rate
    date_founded
    creator_id
    corporation_url
    faction_id
    home_station_id
    shares
  ].freeze

  class ESICall
    include ActiveModel::Model

    attr_accessor :record, :name, :attributes, :relations, :esi_class

    def update
      new_attributes = [build_attributes, build_relations].inject(&:merge)
      record.update(new_attributes)
    end

    def build_attributes
      esi_attributes.slice(*attributes)
    end

    def build_relations
      relations.map do |esi_attribute, name|
        klass = record.class.reflect_on_association(name)&.klass
        raise "No `#{name}' association for `#{record.class.name}'" unless klass
        relation = klass.find_or_create_by(id: esi_attributes[esi_attribute])
        { name => relation }
      end.inject(&:merge)
    end

    def esi_attributes
      @esi_attributes ||= esi_class
                          .new("#{name}_id": record.id)
                          .as_json
                          .with_indifferent_access
    end

    def build_mapping(names)
      Array(names).map do |name|
        name.is_a?(Hash) ? name : { name.to_sym => name }
      end.map(&:merge)
    end
  end

  class << self
    def fetch_job(name, attributes: [], relations: [], class_name: nil)
      class_name = (class_name || name).to_s.classify
      define_method :perform do |record|
        klass = EveOnline::ESI.const_get(class_name)
        helper = ESICall.new(esi_class: klass, record: record, name: name, attributes: attributes, relations: relations)
        helper.update
      end
    end
  end

  fetch_job :corporation,
    attributes: ATTRIBUTES,
    relations: {
      alliance_id: :alliance,
      ceo_id: :ceo
    }
end
