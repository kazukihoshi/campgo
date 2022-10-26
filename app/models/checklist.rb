class Checklist < ApplicationRecord

    #dependent: :destoryではArgumentErrorになったため変更
    has_many :checklist_manages, dependent: :delete_all

    has_many :camps, through: :checklist_manages
    belongs_to :user, optional: true
    belongs_to :category

    scope :site_category, -> { joins(:category).where(categories: { category_name: "サイト" }).distinct }# distinctメソッドで重複を弾く
    scope :cook_category, -> { joins(:category).where(categories: { category_name: "料理" }).distinct }
    scope :tent_category, -> { joins(:category).where(categories: { category_name: "テント泊" }).distinct }
    scope :bonfire_category, -> { joins(:category).where(categories: { category_name: "焚き火" }).distinct }
    scope :others_category, -> { joins(:category).where(categories: { category_name: "その他" }).distinct }

    accepts_nested_attributes_for :checklist_manages, allow_destroy: true

    # def save_checklist_manages
    #   active_checklist_ids = camp.checklist_manages.where(is_active: true).pluck('checklist_id').uniq
    #   checklists = Checklist.where(id: active_checklist_ids)

    #   old_checklists = checklists -
    # end

end
