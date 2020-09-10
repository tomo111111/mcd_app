class InventoriesController < ApplicationController
  def index
    @items = Item.where(user_id:current_user.id)
    if params[:year] && params[:month] && params[:day]
      @inventory_this = Inventory.where(date:"#{params[:year]}-#{params[:month]}-#{params[:day]}",user_id:current_user.id) 
      @date = Date.parse("#{params[:year]}-#{params[:month]}-#{params[:day]}")
    end
  end

  def new
    @inventory = Inventory.new
  end

  def create
    @items = Item.where(user_id:current_user.id)
    date = Date.parse(params[:date])
    i = 0
    @items.each do |item|
      Inventory.create(order:params["order_#{i}".to_sym],use:params["use_#{i}".to_sym],stock:params["stock_#{i}".to_sym],date:params[:date],item_id:item.id,user_id:current_user.id)
      i += 1
      
      #  OrderCalculation.calculation(item,date)
       
      
    end
    flash[:notice] = "#{date}の情報を登録しました"
    redirect_to inventories_path
  end

  def edit
  end

  def update
    @items = Item.where(user_id:current_user.id)
    date = Date.parse(params[:date])
    sale = Sale.find_by(date:date,user_id:current_user.id)
    sale.update(actual:params[:actual])
    i = 0
    @items.each do |item|
      item.inventories.each do |inventory|
        if inventory.date == date
          inventory.update(order:params["order_#{i}".to_sym],use:params["use_#{i}".to_sym],stock:params["stock_#{i}".to_sym],date:params[:date],item_id:item.id,user_id:current_user.id)
        end
      end
      i += 1
      OrderCalculation.calculation(item,date)
    end
    flash[:notice] = "#{date}の情報を登録しました"
    redirect_to inventories_path
  end

end
