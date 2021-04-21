class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar

  mount_uploader :avatar, ImageUploader
  
  def avatar_image
    if @profile&.avatar&.present?
      @profile.avatar.to_s
    else
      'default-avatar.png'
    end
  end

end
