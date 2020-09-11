class DeliveriesController < ApplicationController

def index
  @deliveries = Delivery.where(user_id:current_user.id)
  @special = Special.new
  @specials = Special.where(user_id:current_user.id)
end

def new
  @delivery = Delivery.new
end

def create
  @day_of_week.each do |week|
    Delivery.create(day_of_week:week,check:params["#{week}".to_sym],user_id:current_user.id)
  end
  flash[:notice] = "配送日を登録しました"
  redirect_to deliveries_path
end

def edit
end

def update
  @deliveries = Delivery.where(user_id:current_user.id)
  @deliveries.each do |delivery|
  delivery.update(check:params["#{delivery.day_of_week}".to_sym],user_id:current_user.id)
  end
  flash[:notice] = "配送曜日を登録しました"
  redirect_to deliveries_path
end

def special
  Special.create(spesial_params)
  flash[:notice] = "特別配送日を登録しました"
  redirect_to deliveries_path
end

private

def spesial_params
  params.require(:special).permit(:date).merge(user_id:current_user.id)
end

end
