class Inventory < ApplicationRecord

  belongs_to :user
  belongs_to :item

  with_options numericality:{},allow_blank: true do
    validates :order
    validates :use
    validates :stock
  end
  validates :date,presence:true
end