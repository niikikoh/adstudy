class Article < ApplicationRecord

  has_one_attached :image
  belongs_to :user
  has_many :comments

  mount_uploader :image, ImageUploader

  validates :title, presence: true
  validates :title, length: { minimum: 2, maximum: 100 }
  validates :title, format: { with: /\A(?!@)/ }
  validates :content, presence: true

  def author_name
    user.display_name
  end

  def display_created_at
    I18n.l(created_at, format: :default)
  end

end
