require 'sidekiq/web'
Sidekiq::Web.use Rack::Auth::Basic do |username, password|
 username == ENV["SIDEKIQ_USERNAME"] && password == ENV["SIDEKIQ_PASSWORD"]
end

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :feed_entries, only: [:index], controller: :user_feed_entries
      resources :feeds, only: [:index, :create, :destroy], controller: :user_feeds
    end
  end

  devise_for :users
  mount Sidekiq::Web => '/sidekiq'
end
