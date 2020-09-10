class Inventory < ApplicationRecord

  belongs_to :user
  belongs_to :item

  # with_options format:{with: /\A[0-9]+\z/, message: "is invalid. Input half-width characters."} do
  #   validates :order
  #   validates :use
  #   validates :stock
  # end
end