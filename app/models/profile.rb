class Profile < ApplicationRecord
  belongs_to :user
  has_many :article

  has_one_attached :avatar
end
