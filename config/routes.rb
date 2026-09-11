Rails.application.routes.draw do
 resources :products

  # 注文関連
  resources :orders, only: [:index, :new, :create] do 
    collection do
      post :confirm   # 注文確認
    end

    member do
      get :complete  # 注文完了
    end
  end
  get "mypage/show"
  devise_for :users
  resources :mypage, only: [:show]
  # 商品登録
  resources :products

  # トップページ
  root to: "homes#top"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end