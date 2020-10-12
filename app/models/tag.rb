class Tag < ApplicationRecord
  has_many :article_tags, dependent: :destroy
  has_many :articles, through: :article_tags

  validates :name, presence: true
  validates :name, uniqueness: { case_sensitive: true }

  scope :search, -> (word) {
    where('name like ?', "%#{word}%")
  }

end
