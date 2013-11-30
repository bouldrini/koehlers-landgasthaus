LandgasthausKoehler::Application.routes.draw do

  devise_for :users

  devise_scope :user do
    get 'signin', to: 'devise/sessions#new'
    get 'admin', to: 'devise/sessions#new'
    get 'backend', to: 'devise/sessions#new'
  end

  scope module: 'frontend' do
    namespace :landgasthaus do
      get '/gastrokalender', to: 'pages#gastrokalender'
    end
    namespace :catering do
    end
    get '/home', to: 'pages#home', as: :home
    get '/impressum', to: 'pages#impressum', as: :impressum
    get '/kontakt', to: 'pages#contact', as: :contact
    get '/anfahrt', to: 'pages#arrival', as: :arrival
  end

  namespace :backend do
    get '/dashboard', to: 'dashboard#index'
    namespace :landgasthaus do
      resources :users
      resources :pages do
        resources :page_elements, only: [:create, :edit, :update, :destroy] do
          member do
            post 'upload'
            get 'load_form',to: 'page_elements#load_form', as: 'load_form'
          end
        end
        member do
        end
      end
      resources :galleries
      resources :gallery_images
      resources :events
    end
    namespace :catering do
      resources :users
      resources :pages do
        member do
          resources :page_elements, only: [:create, :update, :destroy] do
            member do
              post 'upload'
            end
          end
        end
      end
      resources :galleries
      resources :gallery_images
      resources :events
    end
  end

  root to: redirect('/home')
end
