class SalesController < ApplicationController
  def index
  end

  def new
    @sales = SaleCollection.new
  end

  def create
    @sales = SaleCollection.new(sales_params)
    @sales.save
  end

  def edit
  end

  def update
  end

private

def sales_params
  params.require(:sales)
end

end
