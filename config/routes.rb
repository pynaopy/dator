Rails.application.routes.draw do
  get 'main/home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :login
  get 'login/verymuch', to: 'login#verymuch'
  root 'login#index'
end
