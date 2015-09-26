Rails.application.routes.draw do

  root to: "pages#dashboard"

  get "list", to: "members#list"

  %w[dashboard].each do |page|
    get "#{page}", to: "pages##{page}"
  end
  
  resources :followups
  resources :members do
    collection do
      post "import"
    end
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
  end
end