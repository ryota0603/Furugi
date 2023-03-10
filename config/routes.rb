Rails.application.routes.draw do
  
root to: "public/homes#top"

 # 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions',
}


# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

# ゲストログイン
devise_scope :customer do
      post 'customers/guest_sign_in', to: 'customers/sessions#guest_sign_in'
end

namespace :admin do
    get 'homes/top'
    resources :maps, only: [:index]
    
    #いいね機能、コメント機能
    resources :items, only: [:index, :new, :show, :edit, :update] do
     resource :favorites
     resources :post_comments, only: [:create, :destroy]
    end
    
    #フォロー機能、フォロワー機能
    resources :customers, only: [:index, :show, :edit, :update] do
     resource :relationships
     get 'followings' => 'relationships#followings', as: 'followings'
     get 'followers' => 'relationships#followers', as: 'followers'
    end
    resources :sessions, only: [:new, :create, :destroy]
     get 'searches/search', as: 'search'
     get 'searches/itemsearch',as: 'itemsearch'
  end

  scope module: :public do
    get 'homes/top'
    get 'homes/about', as: 'about'
    get 'customers/unsubscribe'
    patch 'customers/withdrawal'
    resources :maps, only: [:index]
    #いいね機能、コメント機能
    resources :items, only: [:index, :new, :show, :edit, :update, :create, :destroy] do
     resource :favorites
     resources :post_comments, only: [:create, :destroy]
     # 
    end
    #フォロー機能、フォロワー機能
    resources :customers, only: [:show, :edit, :update] do
     resource :relationships
     get 'followings' => 'relationships#followings', as: 'followings'
     get 'followers' => 'relationships#followers', as: 'followers'
    end
    
    resources :sessions, only: [:new, :create, :destroy]
    resources :registrations, only: [:new, :create]
    get 'searches/search', as: 'search' 
    get 'searches/usersearch', as: 'usersearch'
    get 'favorites/like', as: 'like'
    
  end


end
