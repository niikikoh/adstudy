class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  
  has_one :profile, dependent: :destroy
  has_many :articles


  def display_name
    profile&.nickname || email.split('@').first
  end

  def prepare_profile
    profile || build_profile
  end

end
