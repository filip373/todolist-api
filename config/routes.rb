# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :notes
    end
  end

  mount SwaggerUiEngine::Engine, at: '/api-docs'
end
