Rails.application.routes.draw do
  # 認証関連 (通常は上部に配置します)
  devise_for :users

  # トップページ
  root to: "homes#top"

  # 商品関連
  resources :products

  # カート関連 (単数リソース `resource` にすることで /cart としてスッキリ扱えます)
 resources :carts, only: [:show, :index] do
  # セッションカートに商品を追加、数量を更新、商品を削除するアクション
    collection do
      post :add_product  # カートに商品を追加
    end
    member do
      delete :remove_item  # カートから商品を削除
      post :update_quantity  # カート内の商品数を変更
    end
  end

  # 注文関連
  resources :orders, only: [:index, :new, :create] do 
    collection do
      post :confirm   # 注文確認 (POST /orders/confirm)
    end
    member do
      get :complete   # 注文完了 (GET /orders/:id/complete)
    end
  end

  # マイページ関連
  resource :mypage, only: [:show], controller: 'mypage'

  # ヘルスチェック用 (Rails 7.1以降のデフォルト)
  get "up" => "rails/health#show", as: :rails_health_check

 resources :cart_items, only: [:create, :update, :destroy]  
end