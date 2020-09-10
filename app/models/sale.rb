class Sale < ApplicationRecord
  belongs_to :user

  validates :plan,presence:true,format: {with: /\A[0-9]+\z/, message: "is invalid. Input half-width characters."}
end
