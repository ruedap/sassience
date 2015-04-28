Rails.application.routes.draw do
  resources :sheets, only: [:new, :create]
  root to: 'sheets#new'
end
