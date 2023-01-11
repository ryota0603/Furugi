Rails.application.routes.draw do
  
root to: "public/homes#top"

 # 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

namespace :admin do
    get 'homes/top'
    #いいね機能、コメント機能
    resources :posts, only: [:index, :new, :show, :edit, :update] do
     resource :favorites
     resources :post_comments, only: [:create, :destroy]
    end
    
    resources :customers, only: [:show, :edit, :update] do
     resource :relationships
     get 'followings' => 'relationships#followings', as: 'followings'
     get 'followers' => 'relationships#followers', as: 'followers'
    end
  
    resources :order_details, only: [:update]
    resources :sessions, only: [:new, :create, :destroy]
    get 'searches/searches'
  end

  scope module: :public do
    get 'homes/top'
    get 'homes/about'
    get 'customers/unsubscribe'
    patch 'customers/withdrawal'
    get 'orders/about'
    #いいね機能、コメント機能
    resources :posts, only: [:index, :new, :show, :edit, :update] do
     resource :favorites
     resources :post_comments, only: [:create, :destroy]
    end
    #フォロー機能、フォロワー機能
    resources :customers, only: [:show, :edit, :update] do
     resource :relationships
     get 'followings' => 'relationships#followings', as: 'followings'
     get 'followers' => 'relationships#followers', as: 'followers'
    end
    
    resources :sessions, only: [:new, :create, :destroy]
    resources :registrations, only: [:new, :create]
    resources :searches
    
    
  end

end
