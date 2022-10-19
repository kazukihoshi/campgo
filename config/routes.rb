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
    resources :camps, only: [:new, :index, :create, :show, :edit, :update, :destroy] do
      member do
        patch :update_checklist_manage
      end
       resources :checklists, only: [:edit, :index, :show, :create, :new]
    end


  end

  namespace :admin do


    resources :users, only: [:index, :show, :edit, :update]
    resources :posts, only: [:index, :show, :edti, :update, :destroy]
    resources :categories, only: [:index, :create, :edit, :update] do
      resources :checklists, only: [:index, :create, :show, :edit, :update]
      delete 'checklists/destroy_all' => 'checklists#destroy_all'
    end
    delete 'categories/destroy_all' => 'categories#destroy_all'
    resources :camps, only: [:index, :show]
    get 'camps/search' => 'camps#search'
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
