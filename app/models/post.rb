class Post < ApplicationRecord
  include PgSearch::Model
    has_many :likes
    has_many :comments

    pg_search_scope :search_full_text, 
      against: { title: 'A', body: 'B' },
      using: {
        tsearch: { dictionary: "english" }
      }

    belongs_to :user
    has_many :comments, dependent: :destroy
    has_one_attached :image

    validates :title, presence: true
    validates :body, presence: true
end
