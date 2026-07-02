# db/seeds.rb
# This file populates the database with sample data for development.
# Run with: rails db:seed

puts "Seeding database..."

# ── Users ────────────────────────────────────────────────────────────────────

admin = User.find_or_create_by!(email: "admin@pmlg.com") do |u|
  u.first_name = "Admin"
  u.last_name  = "User"
  u.password   = "password123"
  u.role       = :admin
end

coordinator = User.find_or_create_by!(email: "coordinator@pmlg.com") do |u|
  u.first_name = "Jane"
  u.last_name  = "Smith"
  u.password   = "password123"
  u.role       = :coordinator
end

attendee1 = User.find_or_create_by!(email: "alice@example.com") do |u|
  u.first_name = "Alice"
  u.last_name  = "Johnson"
  u.password   = "password123"
  u.role       = :standard
end

attendee2 = User.find_or_create_by!(email: "bob@example.com") do |u|
  u.first_name = "Bob"
  u.last_name  = "Williams"
  u.password   = "password123"
  u.role       = :standard
end

puts "  Created #{User.count} users"

# ── Events ───────────────────────────────────────────────────────────────────

event1 = Event.find_or_create_by!(title: "Annual Strategy Summit 2025") do |e|
  e.description  = "A full-day summit bringing together leadership and key stakeholders to align on strategic priorities for the year ahead."
  e.start_time   = 2.weeks.from_now.change(hour: 9, min: 0)
  e.end_time     = 2.weeks.from_now.change(hour: 17, min: 0)
  e.location     = "Grand Ballroom, Hilton Sydney"
  e.capacity     = 150
  e.status       = :published
  e.coordinator  = coordinator
end

event2 = Event.find_or_create_by!(title: "Project Management Workshop") do |e|
  e.description  = "A hands-on half-day workshop covering agile methodologies, risk management, and stakeholder communication."
  e.start_time   = 3.weeks.from_now.change(hour: 13, min: 0)
  e.end_time     = 3.weeks.from_now.change(hour: 17, min: 0)
  e.location     = "Training Room B, Level 4, 1 Martin Place, Sydney"
  e.capacity     = 30
  e.status       = :published
  e.coordinator  = coordinator
end

event3 = Event.find_or_create_by!(title: "End of Year Networking Dinner") do |e|
  e.description  = "An evening of networking and celebration to close out the year with clients and partners."
  e.start_time   = 6.weeks.from_now.change(hour: 18, min: 30)
  e.end_time     = 6.weeks.from_now.change(hour: 22, min: 0)
  e.location     = "Rooftop Terrace, The Ivy, Sydney"
  e.capacity     = 80
  e.status       = :draft
  e.coordinator  = coordinator
end

puts "  Created #{Event.count} events"

# ── RSVPs ────────────────────────────────────────────────────────────────────

Rsvp.find_or_create_by!(user: attendee1, event: event1) { |r| r.status = :attending }
Rsvp.find_or_create_by!(user: attendee2, event: event1) { |r| r.status = :maybe }
Rsvp.find_or_create_by!(user: attendee1, event: event2) { |r| r.status = :attending }

puts "  Created #{Rsvp.count} RSVPs"

# ── Announcements ─────────────────────────────────────────────────────────────

Announcement.find_or_create_by!(title: "Venue Confirmed", event: event1) do |a|
  a.body         = "We are pleased to confirm the venue for the Annual Strategy Summit. Please ensure you bring your confirmation email for entry."
  a.pinned       = true
  a.published_at = 1.day.ago
  a.author       = coordinator
end

Announcement.find_or_create_by!(title: "Agenda Now Available", event: event1) do |a|
  a.body         = "The full day agenda has been published. Please review the schedule and come prepared for the afternoon breakout sessions."
  a.pinned       = false
  a.published_at = 12.hours.ago
  a.author       = coordinator
end

Announcement.find_or_create_by!(title: "Pre-reading Materials", event: event2) do |a|
  a.body         = "Please review the attached pre-reading materials before attending the workshop. This will help maximise your learning experience on the day."
  a.pinned       = true
  a.published_at = 2.days.ago
  a.author       = coordinator
end

puts "  Created #{Announcement.count} announcements"
puts "Seeding complete!"
