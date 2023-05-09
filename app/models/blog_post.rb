class BlogPost < ApplicationRecord
  validates :title, presence: :true
  validates :body, presence: :true

  scope :sorted, -> { order(published_at: :desc, updated_at: :desc) }
  scope :draft, -> { where(published_at: nil) }
  scope :scheduled, -> { where('published_at > ?', Time.current) }
  scope :published, -> { where('published_at <= ?', Time.current) }

  def draft?
    published_at.nil?
  end

  def scheduled?
    published_at? && published_at > Time.current
  end

  def published?
    published_at? && published_at <= Time.current
  end
end
