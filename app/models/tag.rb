class Tag < ApplicationRecord


    has_many :post_tags, dependent: :destroy
    has_many :posts, through: :post_tags

    # def self.tag_search(name)
    #     #byebug
    #   if keyword != ""
    #     Post.where('tag LIKE(?)', "%#{name}%")
    #   else
    #     Post.all
    #   end
    # end

  # def self.search(name)
  #   if name != ''
  #     tag = Tag.where(name: search)
  #     tag[0].posts
  #   else
  #     Post.all
  #   end
  # end

end
