Rails.application.routes.draw do
  # 新規商品
  get 'products/new'
  post 'products', to: 'products#create'  # 登録

  # トップページ
  root to: "homes#top"
  
  # 省略

end