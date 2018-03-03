# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :notes
    end
  end

  namespace :auth do
    get '/login', to: 'auths#login'
    get '/callback', to: 'auths#callback'
  end

  mount SwaggerUiEngine::Engine, at: '/api-docs'
end
