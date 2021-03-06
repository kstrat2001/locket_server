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
      member do
        get 'admin'
      end
      resources :image_assets, :only => [ :index, :show, :create, :new, :edit, :update, :destroy ]
      resources :lockets, :only => [ :index, :show, :create, :new, :edit, :update, :destroy ] do
        member do
            patch 'submit'
            patch 'review'
            patch 'accept'
            patch 'reject'
            patch 'resubmit'
            patch 'renew'
        end
      end
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
      resources :lockets, :only => [:show, :index]
    end
  end


end
