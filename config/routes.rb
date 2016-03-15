require 'sidekiq/web'
Sidekiq::Web.use Rack::Auth::Basic do |username, password|
 username == ENV["SIDEKIQ_USERNAME"] && password == ENV["SIDEKIQ_PASSWORD"]
end

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :feeds, only: [:index], controller: :user_feeds
    end
  end

  devise_for :users
  mount Sidekiq::Web => '/sidekiq'
end
