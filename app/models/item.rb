class Item < ApplicationRecord
  belongs_to :user
  has_many :inventories,dependent: :destroy
  
  with_options presence: true do
    validates :name
    validates :margin, numericality: { only_integer: true }

  end
end
