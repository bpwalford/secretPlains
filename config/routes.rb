Rails.application.routes.draw do

root 'splash#index'

get  'about'            => 'splash#about', as: :about

get  'user_fingerprint' => 'get_fingerprint#retrieve', as: :user_fingerprint
get  'comparison'       => 'get_fingerprint#compare', as: :comparison

get  'dashboard'        => 'dashboards#index', as: :dashboard
get  'fingerprint'      => 'dashboards#fingerprint', as: :fingerprint
post 'fingerprint'      => 'dashboards#record_fingerprint', as: :record_fingerprint

resources :users

post 'login'  => 'sessions#create', as: :logging_in
get  'logout' => 'sessions#destroy', as: :logout

end
