class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :role, { standard: 0, coordinator: 1, admin: 2 }

  # Events this user has created as a coordinator
  has_many :created_events, class_name: "Event", foreign_key: "coordinator_id", dependent: :destroy

  # RSVPs and events this user is attending
  has_many :rsvps, dependent: :destroy
  has_many :attended_events, through: :rsvps, source: :event

  # Announcements authored by this user
  has_many :announcements, foreign_key: "author_id", dependent: :destroy

  # Virtual attribute for full name
  def full_name
    "#{first_name} #{last_name}".strip
  end
end
