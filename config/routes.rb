Rails.application.routes.draw do

root 'splash#index'
get 'testprint883' => 'splash#test'

get 'dashboard' => 'dashboards#index', as: :dashboard

resources :users

post 'login' => 'sessions#create', as: :logging_in
get 'logout' => 'sessions#destroy', as: :logout

end
