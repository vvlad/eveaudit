# frozen_string_literal: true

class DashboardsController < ApplicationController
  def show
    @character = Character.find(session[:character_id])
  end
end
