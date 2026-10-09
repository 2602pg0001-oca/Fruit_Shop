 def add_product
    # 空のカートもしくはカートの中に商品がない場合は初期化
    session[:cart] ||= []
    # 商品のIDで商品を取得
    product = Product.find(cart_params[:product_id])
    count = cart_params[:count].to_i
    
    # セッションはJSON形式で保存されるため、ハッシュのキーは文字列で扱う必要があります。
    # セッションで扱う場合はid:ではなく"id"のようにしてください。
    # （シンボルではセッション内で正しく保存・復元できないことがあります）

    # もしまだカートに商品がなければ追加
    if session[:cart].none? { |item| item["id"] == product.id }
      session[:cart] << { "id" => product.id, "count" => count }
    else
    # 既にカートに商品がある場合は数量を更新
      item = session[:cart].find { |item| item["id"] == product.id }
      item["count"] += count if item
    end
    cart_calculation
    redirect_to carts_path, notice: '商品がカートに追加されました。'
  end
  
  def update_quantity        
    # 商品のIDを取得
    product_id = params[:id].to_i
    reduce_count = params[:count].to_i

    # カート内の商品を見つける
    item = session[:cart].find { |item| item["id"] == product_id }

    if item
      # 数量を更新
      item["count"] = reduce_count
      # 数量が0になった場合はカートから削除
      session[:cart].delete(item) if item["count"] <= 0
    end

    # カートの合計金額を再計算
    cart_calculation

    redirect_to carts_path, notice: '商品がカートから削除されました。'
  end

  # カートの商品を削除アクション
  def remove_item

    # 商品のIDを取得
    product_id = params[:id].to_i

    # カートから該当商品を削除
    session[:cart].delete_if { |item| item["id"] == product_id }
    
    # カートの合計金額を再計算
    cart_calculation

    redirect_to carts_path, notice: '商品がカートから削除されました。'
  end


  private

  def cart_params
    params.permit(:product_id, :count)
  end
# ここまで追加
end