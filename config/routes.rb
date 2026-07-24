Rails.application.routes.draw do
  # 新規商品
  get 'products/new'
  post 'products', to: 'products#create'  # 登録

  # 商品一覧
  get 'products', to: 'products#index'

  # トップページ
  root to: "homes#top"

  # 省略

end