class ItemsController < ApplicationController
  


  def index
    @starting_point = Date.today - 7
    @items = Item.all
  end
end
