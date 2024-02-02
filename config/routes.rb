Rails.application.routes.draw do

  devise_for :users

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  root to: 'homes#top'
  get 'homes/about' => 'homes#about', as: "about"
  resources :users, only: [:show, :edit, :update]
  resources :children, only: [:index, :create, :show, :edit, :update]



end
