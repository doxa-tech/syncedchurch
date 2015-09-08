Rails.application.routes.draw do

  get "/list", to: "members#list"
  
  resources :members
  resources :groups do

    member do
      post "add"
      post "toggle"
      delete "remove"
    end

  end

  scope "api" do
    get "/members", to: "api#members"
  end
end