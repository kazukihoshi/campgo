class Post < ApplicationRecord
    
    has_many :comments, dependent: :destroy
    has_many :tags, dependent: :destroy
    has_many :favorites, dependent: :destroy
    
    has_many_attached :post_image
    
end
