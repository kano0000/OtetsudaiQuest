Rails.application.routes.draw do

  devise_for :users

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  root to: 'homes#top'
  get 'homes/about' => 'homes#about', as: "about"
  resources :users, only: [:show, :edit, :update]
  get 'user/menu' => 'users#menu', as: 'menu'
  get 'rewards/order' => 'rewards#order', as: 'order'
  resources :children, only: [:new, :create, :show, :edit, :update]
  get 'children/:id/clear_tasks' => 'children#clear_tasks', as: 'clear_tasks'
  get 'children/:id/order_lists' => 'children#order_lists', as: 'order_lists'
  resources :rewards, only: [:new, :create, :index, :edit, :update] do
    resources :child_rewards, only: [:create]
  end
  get 'rewards/:id/exchange' => 'rewards#exchange', as: 'exchange'
  post 'rewards/:id/complete' => 'rewards#complete', as: 'complete'
  get 'rewards/:id/complete' => 'rewards#complete_view'
  patch 'reward/:child_reward_id/order' => 'rewards#order_update', as: 'order_update'
  resources :task_lists, only: [:index, :create, :update, :destroy]
  resources :tasks, only: [:index, :show, :new, :create, :edit, :update] do
    resources :child_tasks, only: [:update]
  end
  get 'tasks/:id/status_change' => 'tasks#status_change', as: 'status_change'
  post 'tasks/:id/thanks' => 'tasks#thanks', as: 'thanks'
  get 'tasks/:id/thanks' => 'tasks#thanks_view'
  
  post "/chatbots", to: "chatbots#create"
  
  #保護者使用画面
  get 'tasks/:id/admin_index' => 'tasks#admin_index', as: 'tasks_admin_index'
  get 'rewards/:id/admin_index' => 'rewards#admin_index', as: 'rewards_admin_index'

end