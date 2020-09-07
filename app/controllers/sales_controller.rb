class SalesController < ApplicationController
  def index
  end

  def new
    @sale = Sale.new
    @this_month = params[:this_month].to_date
    # @sales = SaleCollection.new
  end

  def create
    Date.parse(params[:date_1]).end_of_month.day.times do |i|
      Sale.create(plan:params["plan_#{i + 1}".to_sym],date:params["date_#{i + 1}".to_sym],user_id:current_user.id)  
    end
    flash[:notice] = "#{Date.parse(params[:date_1]).month}月のセールスプランを登録しました"
    redirect_to sales_path
    # @sales = SaleCollection.new(sales_params)
    # if @sales.save
    #   redirect_to sales_path
    # else
    #   render :new
    # end
  end

  def edit
  end

  def update
    Date.parse(params[:date_1]).end_of_month.day.times do |i|
      Sale.find_by(date:params["date_#{i + 1}".to_sym]).update(plan:params["plan_#{i + 1}".to_sym],user_id:current_user.id)  
    end
    flash[:notice] = "#{Date.parse(params[:date_1]).month}月のセールスプランを更新しました"
    redirect_to sales_path
  end

  # def edit_sales
  #   @this_month = params[:this_month].to_date
  #   @sales = SaleCollection.new
  # end

  # private

  # def sales_params
  #   params.require(:sales)
  # end
end
