Rails.application.routes.draw do
  get 'registrations/new' , to: "registrations#new"
  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "posts#index"
end
