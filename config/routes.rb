Rails.application.routes.draw do

  get "/list", to: "members#list"
  
  resources :members
  resources :groups

end