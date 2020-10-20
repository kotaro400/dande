class Feature < ApplicationRecord
  has_many :articles
  has_one_attached :image

  validates :title, presence: true
  validate :image_presence

  scope :sort_from_newest_to_oldest, -> {
    order(created_at: :desc)
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
