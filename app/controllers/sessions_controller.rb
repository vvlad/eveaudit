# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    character = Character.from_esi(auth)
    @audit = Audit.create!(character: character, access_token: auth.credentials.token)
    session[:character_id] = character.id
    redirect_to @audit
  end
end
