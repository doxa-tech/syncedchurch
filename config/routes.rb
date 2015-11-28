Rails.application.routes.draw do
  mount Adeia::Engine => "/adeia"

  root to: "pages#dashboard"

  get "list", to: "members#list"
  get "agenda", to: "events#agenda"

  %w[dashboard].each do |page|
    get "#{page}", to: "pages##{page}"
  end

  get "user/password/edit", to: "users#edit"

  resources :sessions, only: :create
  delete "logout", to: "sessions#destroy"
  get "login", to: "sessions#new"
  
  resources :followups
  resources :events

  resources :users, only: :index

  resources :members do
    collection do
      post "import"
    end

    resources :users, shallow: true, except: [:index, :new, :edit]
  end


  resources :meetings, only: :index do
    collection do
      get "choose"
    end
  end

  resources :groups do

    member do
      post "add"
      post "toggle"
      delete "remove"
    end

    resources :meetings, shallow: true, except: :index

  end

  scope "api" do
    get "members", to: "api#members"
    get "events", to: "api#events"
  end
end