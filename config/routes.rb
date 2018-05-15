# frozen_string_literal: true

Rails.application.routes.draw do
  get "/auth/:provider/callback", to: "sessions#create"

  resource :dashboard
  resources :audits
  resource :session

  root to: redirect("/session/new")
end
