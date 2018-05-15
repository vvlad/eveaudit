# frozen_string_literal: true

OmniAuth.config.logger = Rails.logger

require Rails.root.join("lib/omniauth/strategies/eve_online")

ESI_SCOPES = %w[
  characterContactsRead
  characterAssetsRead
  characterAccountRead
  characterChatChannelsRead
  characterClonesRead
  esi-mail.read_mail.v1
  esi-skills.read_skills.v1
  esi-skills.read_skillqueue.v1
  esi-wallet.read_character_wallet.v1
  esi-clones.read_clones.v1
  esi-characters.read_contacts.v1
  esi-killmails.read_killmails.v1
  esi-corporations.read_corporation_membership.v1
  esi-characters.read_medals.v1
  esi-characters.read_standings.v1
  esi-characters.read_corporation_roles.v1
  esi-contracts.read_character_contracts.v1
  esi-clones.read_implants.v1
  esi-characters.read_fatigue.v1
  esi-killmails.read_corporation_killmails.v1
  esi-characters.read_titles.v1
  esi-characterstats.read.v1
  esi-characters.read_notifications.v1
].freeze

#
# esi-corporations.read_contacts.v1
# esi-corporations.read_titles.v1
# esi-corporations.read_standings.v1
# esi-corporations.read_container_logs.v1
#

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :eve_online, Rails.application.credentials.esi_app_id, Rails.application.credentials.esi_secret, scope: ESI_SCOPES.join(" ")
end

OmniAuth.config.test_mode = Rails.env.test?
