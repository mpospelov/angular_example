Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root to: "site/home#index"
  devise_for :users

  namespace :api do
    mount_devise_token_auth_for 'User', at: 'auth'
    resources :tasks, only: [:index, :create, :update, :destroy]
  end
end
