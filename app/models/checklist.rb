class Checklist < ApplicationRecord

    #dependent: :destoryではArgumentErrorになったため変更
    has_many :checklist_manages, dependent: :delete_all

    has_many :camps, through: :checklist_manages
    belongs_to :user, optional: true
    belongs_to :category

    scope :site_category, -> { joins(:category).where(categories: { category_name: "サイト" }) }
    scope :cook_category, -> { joins(:category).where(categories: { category_name: "料理" }) }
    scope :tent_category, -> { joins(:category).where(categories: { category_name: "テント泊" }) }
    scope :bonfire_category, -> { joins(:category).where(categories: { category_name: "焚き火" }) }
    scope :others_category, -> { joins(:category).where(categories: { category_name: "その他" }) }

    accepts_nested_attributes_for :checklist_manages, allow_destroy: true

end
