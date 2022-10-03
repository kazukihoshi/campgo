Rails.application.routes.draw do
  
  scope module: :public do
    root to: 'homes#top'
    resouces :users, only: [:index, :edit, :update]
    get 'users/unsubscribe'
    patch 'users/withdraw'
    resouces :posts, only: [:new, :index, :show, :edit, :create, :update, :destroy]
    get 'posts/search'
    resouces :comments, only: [:create, :edit, :update, :destroy]
    resouces :tags, only: [:create, :destroy]
    resouces :favorites, only: [:index, :create, :destroy]
    resouces :camps, only: [:new, :show, :edit, :update, :destroy]
    resouces :checklists, only: [:edit]
    reosuces :checklist_manages, only: [:update]
  end
  
  namespace :admin do
    resouces :checklists, only: [:index, :show, :edit, :update]
    resouces :users, only: [:index, :show, :edit, :update]
    resouces :posts, only: [:show, :edti, :update, :destroy]
    resouces :categories, only: [:create, :destroy]
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
