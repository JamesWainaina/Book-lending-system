class Book < ApplicationRecord
    has_one_attached :image

    belongs_to :user, optional: true

    validates :title, presence: true
    validates :author, presence: true
    validates :isbn, presence: true, uniqueness: { message: "has already been taken"}


    def borrowed?
        user.present?
    end
end
