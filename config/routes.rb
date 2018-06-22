# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :reports, only: [:create, :index]
    end
  end
end
