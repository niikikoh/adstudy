class Profile < ApplicationRecord
  belongs_to :user
  has_many :articles

  has_one_attached :avatar

  mount_uploader :avatar, ImageUploader

  def avatar_image
    if @profile&.avatar&.attached?
      @profile.avatar
    else
      'default-avatar.png'
    end
  end
end
