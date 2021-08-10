Rails.application.routes.draw do
  get '/herbs' => 'herb#index', as: 'herbs'
  get '/herbs/:id' => 'herb#show', as: 'herb'
  root 'herb#index'
end
