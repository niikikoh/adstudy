class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  
  has_one :profile,   dependent: :destroy
  has_many :articles, dependent: :destroy

  # profileの値をユーザー側で使用許可&nilをスキップ
  delegate :name, :bio, :avatar, to: :profile, allow_nil: true


  def display_name
    profile&.name || email.split('@').first
  end

  def prepare_profile
    profile || build_profile
  end

  def avatar_image
    if @profile&.avatar&.present?
      @profile.avatar.to_s
    else
      'default-avatar.png'
    end
  end

end
