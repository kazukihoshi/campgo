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
end
