class ItemsController < ApplicationController
  
  def index
    @starting_point = Date.today - 7
    @items = Item.all
  end

  def new
    @items = Item.all
    @item = Item.new
  end

  def create
    Item.create(item_params)
    flash[:notice] = "新規アイテム（#{params[:item][:name]}）を登録しました"
    redirect_to new_item_path
  end

  def edit
  end

  def update
    items = Item.all
    i = 0
    items.each do |item|
      item.update(margin:params["margin_#{i}".to_sym])
      i += 1
    end
    flash[:notice] = "基準在庫数を登録しました"
    redirect_to new_item_path
  end

  def destroy
    item = Item.find(params[:name])
    item.destroy
    flash[:notice] = "品目（#{item.name}）を削除しました"
    redirect_to new_item_path
  end

private

def item_params
  params.require(:item).permit(:name,:margin).merge(user_id:current_user.id)
end

end
