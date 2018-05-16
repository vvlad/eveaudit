# frozen_string_literal: true

Sidekiq.configure_server do |_config|
  if Rails.env.development?
    Rails.logger = Sidekiq.logger
    ActiveRecord::Base.logger = Sidekiq.logger
  else
    Sidekiq.logger = Rails.logger
  end
end
