# frozen_string_literal: true

require "test_helper"

class AuditJobTest < ActiveJob::TestCase
  test "character affiliation" do
    mock = Minitest::Mock.new
    mock.expect :map, [] do |*_args|
      [{ "notification_id" => 823_083_503,
         "sender_id" => 1_000_125,
         "sender_type" => "corporation",
         "text" => "allianceID: 99005955\nsolarSystemID: 30003697\n",
         "timestamp" => "2018-05-15 12:42:00 UTC",
         "type" => "AllianceCapitalChanged" }]
    end

    audit = audits(:one)

    ESI.stub :character_notifications, mock do
      perform_enqueued_jobs { AuditJob.perform_later(audit) }
    end

    character = audit.character
    assert character.corporation_memberships.count.positive?
  end
end
