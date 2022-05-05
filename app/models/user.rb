class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, presence: true
  validates :last_name, presence: true
  validates :first_name, presence: true
  scope :all_except, -> (user) {where.not(id:user)}
  after_create_commit {broadcast_append_to "users"}
  has_one_attached :avatar
  after_commit :add_default_avatar, on: %i[create update]
  has_many :messages
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :friends

  def avatar_thumbnail
    if avatar.attached?
      avatar.variant(resize_to_fill: [150, nil]).processed
    else
      "/default_profile.jpg"
    end
  end

  private

  def add_default_avatar
    unless avatar.attached?
      avatar.attach(
        io: File.open(
          Rails.root.join(
            'app', 'assets', 'images', 'default_profile.jpg'
          )
        ), filename: 'default_profile.jpg',
        content_type: 'image/jpg'
      )
    end
  end
end
