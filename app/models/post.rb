class Post < ApplicationRecord
  validates :body, presence: true, length: {minimum: 5, maximum: 1000}
  belongs_to :user
  has_many :comments, dependent: :destroy
end
