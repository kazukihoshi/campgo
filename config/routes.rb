Rails.application.routes.draw do

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # devise_scope :users do
  #   post 'users/guest_sign_in', to: 'public/sessions#new_guest'
  # end

  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end


  scope module: :public do
    root to: 'homes#top'
    get 'users/unsubscribe'
    patch 'users/withdraw'
    resources :users, only: [:index, :edit, :update, :show] do
      get 'my_checklist_index' => 'checklists#my_checklist_index'
      get 'edit_for_user' => 'checklists#edit_for_user'
      resources :checklists, only: [:edit, :update, :destroy]
    end

    #get 'users/my_page' => 'users#show'
    get 'posts/search'
    get 'posts/search_tag'
    resources :posts, only: [:new, :index, :show, :edit, :create, :update, :destroy] do
      resources :comments, only: [:create, :edit, :update, :destroy] #ネストさせる
      resources :favorites, only: [:create, :destroy]

    end
    #get 'posts/search'
    resources :tags, only: [:index, :show, :create, :destroy]
    resources :favorites, only: [:index, :create, :destroy]
    resources :camps, only: [:new, :index, :create, :show, :edit, :update, :destroy] do
      member do
        patch :update_checklist_manage
        patch :update_all_checklist_manage
      end
       resources :checklists, only: [:index, :show, :create, :new]
       get 'index_for_camp' => 'checklists#index_for_camp'
    end
   #get 'my_checklist_index' => 'checklists#my_checklist_index'

  end

  namespace :admin do


    resources :users, only: [:index, :show, :edit, :update] do
      get 'index_for_user'=> 'checklists#index_for_user'
      resources :checklists, only: [:destroy]
    end
    resources :posts, only: [:index, :show, :edti, :update, :destroy] do
      resources :comments, only: [:destroy]
      resources :tags, only: [:index,:create, :destroy]
    end

    resources :categories, only: [:index, :create, :edit, :update] do
      resources :checklists, only: [:index, :create, :show, :edit, :update]
      delete 'checklists/destroy_all' => 'checklists#destroy_all'
    end
    delete 'categories/destroy_all' => 'categories#destroy_all'
    resources :camps, only: [:index, :show, :destroy]
    get 'camps/search' => 'camps#search'
    get '/' => 'homes#top'
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
