class InventoriesController < ApplicationController
  def index
    @items = Item.all
    if params[:year] && params[:month] && params[:day]
      @inventory_this = Inventory.where(date:"#{params[:year]}-#{params[:month]}-#{params[:day]}") 
      @date = Date.parse("#{params[:year]}-#{params[:month]}-#{params[:day]}")
    end
  end

  def new
    @inventory = Inventory.new
  end

  def create
    @items = Item.all
    i = 0
    @items.each do |item|
      Inventory.create(order:params["order_#{i}".to_sym],use:params["use_#{i}".to_sym],stock:params["stock_#{i}".to_sym],date:params[:date],item_id:item.id,user_id:current_user.id)
      i += 1
    end
    flash[:notice] = "登録しました"
    redirect_to inventories_path
  end

  def edit
  end

  def update
    @items = Item.all
    i = 0
    @items.each do |item|
      item.inventories.each do |inventory|
        if inventory.date == Date.parse(params[:date])
          inventory.update(order:params["order_#{i}".to_sym],use:params["use_#{i}".to_sym],stock:params["stock_#{i}".to_sym],date:params[:date],item_id:item.id,user_id:current_user.id)
        end
      end
      i += 1
    end
    flash[:notice] = "登録しました"
    redirect_to inventories_path
  end

end
