# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :detect, only: :create
      resources :report, only: :create
    end
  end
end
