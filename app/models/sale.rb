class Sale < ApplicationRecord
  belongs_to :user

  validates :plan,presence:true
end
