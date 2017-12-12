Rails.application.routes.draw do
  root "refuels#index"
  resources :refuels
end
