class SalesController < ApplicationController
  def index
  end

  def new
    @this_month = params[:this_month].to_date
    @sales = SaleCollection.new
  end

  def create
    @sales = SaleCollection.new(sales_params)
    if @sales.save
      redirect_to sales_path
    else
      render :new
    end
  end

  def edit_sales
    @this_month = params[:this_month].to_date
    @sales = SaleCollection.new
  end

  private

  def sales_params
    params.require(:sales)
  end
end
