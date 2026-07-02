class Rsvp < ApplicationRecord
  enum :status, { attending: 0, maybe: 1, declined: 2 }

  belongs_to :user
  belongs_to :event

  validates :user_id, uniqueness: {
    scope: :event_id,
    message: "has already RSVP'd to this event"
  }

  validate :event_not_full, on: :create
  validate :event_is_published

  private

  def event_not_full
    return unless event&.full?
    errors.add(:base, "This event has reached its maximum capacity")
  end

  def event_is_published
    return unless event
    unless event.published?
      errors.add(:base, "You can only RSVP to published events")
    end
  end
end
