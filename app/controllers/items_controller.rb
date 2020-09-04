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
    redirect_to new_item_path
  end

  def destroy
    item = Item.find(params[:name])
    item.destroy
    redirect_to new_item_path
  end

private

def item_params
  params.require(:item).permit(:name,:margin).merge(user_id:current_user.id)
end

end
