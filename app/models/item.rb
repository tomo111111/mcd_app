class Item < ApplicationRecord
  belongs_to :user
  has_many :inventories,dependent: :destroy
  
  with_options presence: true do
    validates :name
    validates :margin, format: {with: /\A[0-9]+\z/, message: "is invalid. Input half-width characters."}

  end
end
