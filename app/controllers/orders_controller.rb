class OrdersController < ApplicationController
  def new
    @order = Order.new   # 新しい注文オブジェクトを作成
    @product = Product.find(params[:product_id])   # URLから商品を取得
  end
end