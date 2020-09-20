class Sale < ApplicationRecord
  belongs_to :user

  validates :plan, presence:true, numericality:{only_integer: true}
  validates :actual, numericality:{only_integer: true},allow_blank: true
  validates :date, presence:true
end
