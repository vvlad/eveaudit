# frozen_string_literal: true

module ESI::Oauth
  extend ActiveSupport::Concern
  module ClassMethods
    def from_esi(auth)
      find_or_initialize_by(id: auth.uid).tap(&:sync!)
    end
  end
end
