Rails.application.routes.draw do

root 'splash#index'

get 'dashboard' => 'dashboards#index', as: :dashboard
get 'fingerprint' => 'dashboards#fingerprint', as: :fingerprint
post 'fingerprint' => 'dashboards#record_fingerprint', as: :record_fingerprint
get 'user_fingerprint' => 'get_fingerprint#retrieve', as: :user_fingerprint

get 'testprint883' => 'splash#test'

resources :users

post 'login' => 'sessions#create', as: :logging_in
get 'logout' => 'sessions#destroy', as: :logout

end
