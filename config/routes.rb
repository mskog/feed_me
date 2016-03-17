require 'sidekiq/web'
Sidekiq::Web.use Rack::Auth::Basic do |username, password|
 username == ENV["SIDEKIQ_USERNAME"] && password == ENV["SIDEKIQ_PASSWORD"]
end

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :feeds, only: [:index, :create], controller: :user_feeds do
        member do
          resources :entries, only: [:index], controller: :user_feed_entries
        end
      end
    end
  end

  devise_for :users
  mount Sidekiq::Web => '/sidekiq'
end
