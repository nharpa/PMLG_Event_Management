class Event < ApplicationRecord
  enum :status, { draft: 0, published: 1, cancelled: 2 }

  belongs_to :coordinator, class_name: "User"

  has_many :rsvps, dependent: :destroy
  has_many :attendees, through: :rsvps, source: :user

  has_many :announcements, dependent: :destroy

  validates :title, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :status, presence: true
  validate  :end_time_after_start_time

  # Scopes
  scope :upcoming, -> { published.where("start_time > ?", Time.current).order(:start_time) }
  scope :past,     -> { published.where("end_time < ?", Time.current).order(start_time: :desc) }

  def spots_remaining
    return nil if capacity.nil?
    capacity - rsvps.attending.count
  end

  def full?
    return false if capacity.nil?
    spots_remaining <= 0
  end

  private

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?
    if end_time <= start_time
      errors.add(:end_time, "must be after the start time")
    end
  end
end
