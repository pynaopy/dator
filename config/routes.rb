Rails.application.routes.draw do
  get 'main/home'
  post 'main/home', to: 'main#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'login/show', to: 'login#show'
  root 'login#index'
end
