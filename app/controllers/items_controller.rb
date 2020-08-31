class ItemsController < ApplicationController
  require "date"


  def index
    @day_of_week = %w(日 月 火 水 木 金 土)
    @starting_point = Date.today - 7
    @items = Item.all
  end
end
