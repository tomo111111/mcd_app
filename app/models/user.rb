class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  with_options presence:true do
    validates :store_name,format:{with:/店\z/, message:"「◯◯店」と入力してください。"}
    validates :store_number, format:{with:/\A\d{6}/, message:"6桁の数字を入力してください。"}
  end
  
  has_many :items
  has_many :sales
end
