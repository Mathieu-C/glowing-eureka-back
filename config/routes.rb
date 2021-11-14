Rails.application.routes.draw do
  get 'reviews' => 'reviews#index'
  get 'reviews/live' => 'reviews#live'

  post 'reviews' => 'reviews#create'
end
