class Article < ApplicationRecord
  has_rich_text :content
  has_one_attached :image

  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags

  belongs_to :feature, optional: true

  validates :title, presence: true
  validate :image_presence

  scope :search, -> (word) {
    on_public.where('title like ?', "%#{word}%").sort_from_newest_to_oldest
  }

  scope :sort_from_newest_to_oldest, -> {
    order(created_at: :desc)
  }

  scope :on_public, -> {
    where(public: true).sort_from_newest_to_oldest
  }

  scope :draft, -> {
    where(public: nil).sort_from_newest_to_oldest
  }

  scope :for_engineer, -> {
    on_public.where(for_engineer: true).sort_from_newest_to_oldest
  }

  scope :for_designer, -> {
    on_public.where(for_designer: true).sort_from_newest_to_oldest
  }

  scope :for_designer_or_designer, -> {
    on_public.where(for_designer: true)
      .or(on_public.where(for_engineer: true)).sort_from_newest_to_oldest
  }

  private
  def image_presence
    if image.attached?
      if !image.content_type.in?(%('image/jpeg image/png'))
        errors.add(:image, 'にはjpegまたはpngファイルを設定してください')
      end
    else
      errors.add(:image, 'を設定してください')
    end
  end
end
