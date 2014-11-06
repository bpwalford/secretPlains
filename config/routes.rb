Rails.application.routes.draw do

root 'splash#index', as: :root

resources :users

get 'login' => 'sessions#index'
get 'login' => 'sessions#create'
delete 'logout' => 'sessions#destroy'

end
