class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  
  belongs_to :profile, optional: true
  has_many :articles


  def display_name
    profile&.nickname || email.split('@').first
  end

end
