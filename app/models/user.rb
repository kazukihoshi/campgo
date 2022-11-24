class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :camps, dependent: :destroy
  has_many :checklists, dependent: :destroy
  has_many :checklist_manages, dependent: :destroy

  has_one_attached :profile_image
  has_one_attached :background_image

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  #validates :password_confirmation, presence: true
  # validates :number_of_people, presence: true

  validates :profile_image, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'] }

  def get_profile_image
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    pp ActiveStorage::Attachment.find(profile_image.id)
    #profile_image.variant(resize_to_limit: [width, height]).processed
  end

  # def get_background_image(width, height)
  #   unless background_image.attached?
  #     file_path = Rails.root.join('app/assets/images/default-background-image.jpg')
  #     background_image.attach(io: File.open(file_path), filename: 'default-background-image.jpg', content_type: 'image/jpeg')
  #   end
  #   background_image.variant(resize_to_limit: [width, height]).processed
  # end


  # def self.guest
  #   find_or_create_by!(email: 'guest@example.com') do |user|
  #     user.password = SecureRandom.urlsafe_base64
  #     # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
  #     # 例えば name を入力必須としているならば， user.name = "ゲスト" なども必要
  #   end
  # end

  # def active_for_authentication?
  #   super && (is_delete == false)
  # end

end
