class ItemsController < ApplicationController
  
  def index
    @items = Item.where(user_id:current_user.id)
    @comment = Comment.new
    @comments = Comment.all
  end

  def new
    @items = Item.where(user_id:current_user.id)
    @item = Item.new
  end

  def create
    @items = Item.where(user_id:current_user.id)
    item =  Item.new(item_params)
    if item.save
      flash[:notice] = "新規アイテム（#{params[:item][:name]}）を登録しました"
      redirect_to new_item_path
    else
      @item = Item.new
      render :new
    end
  end

  def edit
  end

  def update
    items = Item.where(user_id:current_user.id)
    i = 0
    items.each do |item|
      item.update(margin:params["margin_#{i}".to_sym])
      i += 1
    end
    flash[:notice] = "基準在庫数を更新しました"
    redirect_to new_item_path
  end

  def destroy
    if params[:name] != ""
      item = Item.find(params[:name])
      item.destroy
      flash[:notice] = "品目（#{item.name}）を削除しました"
    end
    redirect_to new_item_path
  end

  private

  def item_params
    params.require(:item).permit(:name,:margin).merge(user_id:current_user.id)
  end

end
