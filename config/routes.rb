Rails.application.routes.draw do
  
  scope module: :public do
    root to: 'homes#top'
    resources :users, only: [:index, :edit, :update]
    get 'users/unsubscribe'
    patch 'users/withdraw'
    get 'users/my_page' => 'users#show'
    resources :posts, only: [:new, :index, :show, :edit, :create, :update, :destroy]
    get 'posts/search'
    resources :comments, only: [:create, :edit, :update, :destroy]
    resources :tags, only: [:create, :destroy]
    resources :favorites, only: [:index, :create, :destroy]
    resources :camps, only: [:new, :show, :edit, :update, :destroy]
    resources :checklists, only: [:edit]
    resources :checklist_manages, only: [:update]
  end
  
  namespace :admin do
    resources :checklists, only: [:index, :show, :edit, :update]
    resources :users, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :show, :edti, :update, :destroy]
    resources :categories, only: [:index, :create, :destroy]
    resources :camps, only: [:index]
    get '/' => 'homes#top'
  end
  
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
