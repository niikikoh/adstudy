class Article < ApplicationRecord

  has_one_attached :image
  belongs_to :user

  mount_uploader :image, ImageUploader

  def author_name
    user.display_name
  end

  def display_created_at
    I18n.l(created_at, format: :default)
  end

  def image_attached?
    - if current_user.image.exists?
      = current_user.image, class: 'header_avatar dropbtn'
    - else
      = 'default-avatar.png', class: 'header_avatar dropbtn'
    end
  end
      
end
