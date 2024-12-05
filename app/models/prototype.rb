class Prototype < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy

  has_one_attached :image

  validates :title, presence: true, length: { minimum: 5 }
  validates :catch_copy, presence: true, length: { minimum: 5 }
  validates :concept, presence: true, length: { minimum: 5 }
  validates :image, presence: true
end
