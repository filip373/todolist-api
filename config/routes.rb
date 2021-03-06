# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :lists
      resources :notes
    end
  end

  namespace :auth do
    get '/login', to: 'auths#login'
    get '/callback', to: 'auths#callback'
  end

  mount SwaggerUiEngine::Engine, at: '/api-docs'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
