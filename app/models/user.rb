class User < ApplicationRecord
  
  has_one_attached :photo
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :recoverable and :omniauthable
  devise :database_authenticatable, :registerable,
         :trackable, :rememberable, :validatable
   has_many :orders      

has_one :cart
  def thumbnail
    # photo.variantで画像を加工し、resize_to_fitで縦横比を維持したまま、指定したサイズにリサイズ
    photo.variant(resize_to_fit: [200, 200]).processed
  end
         
end