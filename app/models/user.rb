class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  
  has_one :profile,   dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy

  # followのアソシエーション
  has_many :relationships
  has_many :following, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user

  # likesのアソシエーション
  has_many :likes, dependent: :destroy
  has_many :liked_articles, through: :likes, source: :article

  # profileの値をユーザー側で使用許可&nilをスキップ
  delegate :name, :bio, :avatar, to: :profile, allow_nil: true

  def has_written?(article)
    articles.exists?(id: article.id)
  end

  # フォロー関連のメソッド
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.following.include?(other_user)
  end

  # profileでuserの名前を表示
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

  def already_liked?(article)
    self.likes.exists?(article_id: article.id)
  end

end
