class Post < ApplicationRecord

    has_many :post_tags, dependent: :destroy#中間テーブルとのアソシエーションを先に記載
    has_many :tags, through: :post_tags

    has_many :favorites, dependent: :destroy
    has_many :comments, dependent: :destroy

    has_many_attached :post_images


    def save_tags(tags)

        tag_list = tags.split(/[[:blank:]]+/)
        current_tags =self.tags.pluck(:name)
        old_tags = current_tags - tag_list
        new_tags = tag_list - current_tags

        old_tags.each do |old|
          self.tags.delete Tag.find_by(name: old)
        end

        new_tags.each do |new|
            new_post_tag = Tag.find_or_create_by(name: new)
            self.tags << new_post_tag
        end

    end
end
