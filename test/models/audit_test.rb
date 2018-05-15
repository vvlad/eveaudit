# frozen_string_literal: true

require "test_helper"

class AuditTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  test "validations" do
    audit = Audit.new
    audit.validate
    assert_includes audit.errors, :access_token
    assert_includes audit.errors, :character

    audit.assign_attributes(access_token: "the token", character: characters(:one))
    audit.validate

    assert_not_includes audit.errors, :access_token
    assert_not_includes audit.errors, :character
  end

  test "async validation" do
    audit = Audit.new(access_token: "the token", character: characters(:one))

    assert_enqueued_jobs 1, only: AuditJob do
      audit.save
    end
  end
end
