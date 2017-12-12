Rails.application.routes.draw do
  devise_for :users
  root "refuels#index"
  resources :refuels
end
