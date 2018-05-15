# frozen_string_literal: true

require "test_helper"

class CharacterTest < ActiveSupport::TestCase
  CHARACTER_ID = 1_259_994_801

  test "should import the data from esi" do
    character = Character.new(id: CHARACTER_ID)
    character.validate
    assert_not_includes character.errors, :name
    assert_not_includes character.errors, :corporation
  end

  test "oauth" do
    character = Character.from_esi(oauth)
    assert character.persisted?
    assert character.name?
    assert character.birthday?
    assert character.corporation_id?
  end

  def oauth
    @oauth ||= OmniAuth::AuthHash.new(dataset.yaml(:oauth))
  end
end
