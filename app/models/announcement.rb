class Announcement < ApplicationRecord
  belongs_to :event
  belongs_to :author, class_name: "User"

  validates :title, presence: true
  validates :body,  presence: true

  # Scopes
  scope :published,    -> { where.not(published_at: nil).where("published_at <= ?", Time.current) }
  scope :drafts,       -> { where(published_at: nil) }
  scope :pinned_first, -> { order(pinned: :desc, published_at: :desc) }

  def published?
    published_at.present? && published_at <= Time.current
  end

  def draft?
    published_at.nil?
  end

  def publish!
    update!(published_at: Time.current)
  end
end
