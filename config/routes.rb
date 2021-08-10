Rails.application.routes.draw do
  get '/herbs' => 'herb#index'
  root 'herb#index'
end
