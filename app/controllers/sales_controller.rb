class SalesController < ApplicationController
  def index
  end

  def new
    @sale = Sale.new
    @this_month = params[:this_month].to_date
  end

  def create
    Date.parse(params[:date_1]).end_of_month.day.times do |i|
      Sale.create(plan:params["plan_#{i + 1}".to_sym],date:params["date_#{i + 1}".to_sym],user_id:current_user.id)  
    end
    flash[:notice] = "#{Date.parse(params[:date_1]).month}月のセールスプランを登録しました"
    redirect_to sales_path
  end

  def edit
  end

  def update
    Date.parse(params[:date_1]).end_of_month.day.times do |i|
      sale = Sale.find_by(date:params["date_#{i + 1}".to_sym])
      if sale
        sale.update(plan:params["plan_#{i + 1}".to_sym],user_id:current_user.id)  
      else
        Sale.create(plan:params["plan_#{i + 1}".to_sym],date:params["date_#{i + 1}".to_sym],user_id:current_user.id)
      end
    end
    flash[:notice] = "#{Date.parse(params[:date_1]).month}月のセールスプランを更新しました"
    redirect_to sales_path
  end

end
