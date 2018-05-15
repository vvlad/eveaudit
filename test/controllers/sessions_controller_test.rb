# frozen_string_literal: true

require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup :auth_setup
  teardown :auth_cleanup

  test "esi integration" do
    assert_changes "Audit.count" do
      get "/auth/eve_online/callback"
    end
    assert_includes session, :character_id
    assert_redirected_to assigns(:audit)
  end

  private

    def auth_setup
      OmniAuth.config.add_mock(:eve_online, dataset.yaml(:oauth))
    end

    def auth_cleanup
      OmniAuth.config.mock_auth[:eve_online] = nil
    end
end
