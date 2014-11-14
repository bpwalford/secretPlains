Rails.application.routes.draw do

root 'splash#index', as: :root
get 'testprint883' => 'splash#test'

get 'dashboard' => 'dashboards#index', as: :dashboard

resources :users

get 'login' => 'sessions#index'
post 'login' => 'sessions#create', as: :logging_in
get 'logout' => 'sessions#destroy', as: :logout

end
