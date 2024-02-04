Rails.application.routes.draw do

  devise_for :users

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  
  root to: 'homes#top'
  get 'homes/about' => 'homes#about', as: "about"
  resources :users, only: [:show, :edit, :update]
  get 'user/menu' => 'users#menu', as: 'menu'
  resources :children, only: [:new, :create, :show, :edit, :update]
  resources :rewards, only: [:new, :create, :index, :show, :edit, :update]
  resources :task_lists, only: [:index, :create, :edit, :update, :destroy]
  resources :tasks, only: [:index, :show, :new, :create, :edit, :update]
  post 'tasks/:id/start' => 'tasks#start', as: 'start'
  post 'tasks/:id/finish' => 'tasks#finish', as: 'finish'
  get 'tasks/thanks' => 'tasks#thanks', as: 'thanks'
end