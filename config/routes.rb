Rails.application.routes.draw do
  get 'reviews' => 'reviews#index'
  post 'reviews' => 'reviews#create'
end
