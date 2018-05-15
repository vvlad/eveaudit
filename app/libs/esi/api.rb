# frozen_string_literal: true

class ESI::Api
  attr_reader :token

  def initialize(token)
    @token = token
  end

  def client
    @client ||= Faraday.new(url: "https://esi.evetech.net") do |faraday|
      faraday.request :json
      faraday.response :json
      faraday.response :logger if Rails.env.development?
      faraday.response :raise_error
      faraday.use :instrumentation
      faraday.authorization :Bearer, token if token

      faraday.adapter Faraday.default_adapter
    end
  end

  def get(path, params = {})
    keys = path.scan(%r{/\{(.+)\}/}).flatten.map(&:to_sym)
    path = path.gsub(%r{/\{}, "/%{")
    result = client.get(format(path, params.slice(*keys)), params.except(*keys)).body
    if result.is_a? Array
      result.map { |object| Hashie::Mash.new(object) }
    else
      Hashie::Mash.new(result)
    end
  end
end
