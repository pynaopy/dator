Rails.application.routes.draw do
  get 'main/home'
  post 'main/home', to: 'main#home'
  post 'main/create', to: 'main#create'
  post 'main/update', to: 'main#update'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'login/show', to: 'login#show'
  post 'login/signup', to: 'login#signup'
  post 'login/signin', to: 'login#signin'
#  resource :login
  root 'login#index'
end
