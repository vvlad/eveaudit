# frozen_string_literal: true

class AuditsController < ApplicationController
  def show
    @audit = Audit.find(params[:id])
    @character = @audit.character
  end
end
