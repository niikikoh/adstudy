class Article < ApplicationRecord 
  belongs_to :user
  has_many :comments

  has_many :likes
  has_many :liked_users, through: :likes, source: :user

  has_rich_text     :content
  has_many_attached :images

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
