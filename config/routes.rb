Rails.application.routes.draw do

  if Rails.env.development?
    mount SabisuRails::Engine => "/sabisu_rails"
  end

  devise_for :users

  get 'welcome/index'

  # The "home page"
  root 'welcome#index'

  namespace :site do
    resources :users, :only => [ :show ] do
      resources :image_assets, :only => [ :show, :create, :new, :edit, :update, :destroy ]
      resources :lockets, :only => [ :show, :create, :new, :edit, :update, :destroy ]
    end
  end

  namespace :api, defaults: { format: :json },
                              constraints: { subdomain: 'api' }, path: '/' do
    scope module: :v1,
                  constraints: ApiConstraints.new(version: 1, default: true) do

        resources :users, :only => [:show, :create, :update, :destroy] do
        resources :image_assets, :only => [:create, :update, :destroy]
      end

      resources :sessions, :only => [:create, :destroy]
      resources :image_assets, :only => [:show, :index]
    end
  end
  

end
