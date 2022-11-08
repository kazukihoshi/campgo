class Post < ApplicationRecord

    has_many :post_tags, dependent: :destroy#中間テーブルとのアソシエーションを先に記載
    has_many :tags, through: :post_tags

    has_many :favorites, dependent: :destroy
    has_many :comments, dependent: :destroy
    belongs_to :user

    has_many_attached :post_images

    validates :post, presence: true
    validates :camp_site, presence: true
    validates :post_images, presence: true
    validates :title, presence: true
    #validates :tag, presence: true

    def save_tags(tags)
        tag_list = tags.split(/[[:blank:]]+/) #配列を分割する
        current_tags =self.tags.pluck(:name)
        old_tags = current_tags - tag_list
        new_tags = tag_list - current_tags

        # self.tags.where(name: old_tags).delete_all

        old_tags.each do |old|
          self.tags.delete Tag.find_by(name: old)
        end

        new_tags.each do |new|
            new_post_tag = Tag.find_or_create_by(name: new)
            self.tags << new_post_tag
        end

    end

    def self.search(keyword)
      #byebug
      if keyword != ""
        Post.where('title LIKE(?)', "%#{keyword}%")
        Post.where('post LIKE(?)', "%#{keyword}%")
      else
        Post.all
      end
    end

    # def self.search(name)
    #   if name != ''
    #     tag = Tag.where(name: search)
    #     tag[0].posts
    #   else
    #     Post.all
    #   end
    # end

    def favorited?(user)
      favorites.where(user_id: user.id).exists?
    end


end
