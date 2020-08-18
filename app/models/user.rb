class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable#, :omniauthable, omniauth_providers:[:twitter]

  has_many :posts, dependent: :destroy
  validates :name,  presence: true
end
