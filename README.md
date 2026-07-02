# PMLG Event Management

A Ruby on Rails web portal for managing events. Event coordinators can create and manage events, post announcements, and registered users can RSVP to attend.

## Technology Stack

- **Framework:** Ruby on Rails 8.1
- **Database:** SQLite3 (development), configurable for PostgreSQL in production
- **Authentication:** Devise
- **Ruby Version:** 3.2+

## Data Schema

The application is built around four core models:

| Model | Description |
| :--- | :--- |
| `User` | Handles authentication and roles (`standard`, `coordinator`, `admin`) |
| `Event` | Events created by coordinators with status lifecycle (`draft`, `published`, `cancelled`) |
| `Rsvp` | Join model linking users to events with attendance status (`attending`, `maybe`, `declined`) |
| `Announcement` | Posts made by coordinators against a specific event, with pinning and scheduled publishing |

## Getting Started

### Prerequisites

- Ruby 3.2+
- Bundler
- Node.js (for asset pipeline)

### Setup

```bash
# Clone the repository
git clone https://github.com/nharpa/PMLG_Event_Management.git
cd PMLG_Event_Management

# Install dependencies
bundle install

# Set up the database
rails db:migrate
rails db:seed

# Start the development server
rails server
```

The application will be available at `http://localhost:3000`.

### Seed Data

Running `rails db:seed` will create the following sample records:

**Users**

| Email | Password | Role |
| :--- | :--- | :--- |
| admin@pmlg.com | password123 | admin |
| coordinator@pmlg.com | password123 | coordinator |
| alice@example.com | password123 | standard |
| bob@example.com | password123 | standard |

**Events:** 3 sample events (2 published, 1 draft) with RSVPs and announcements attached.

## Key Model Behaviours

- **Event capacity enforcement:** RSVPs are blocked once an event reaches its `capacity` limit.
- **RSVP uniqueness:** A user can only RSVP once per event (enforced at both model and database level).
- **Announcement scheduling:** Setting `published_at` to a future datetime allows announcements to be scheduled. A `nil` value means the announcement is a draft.
- **Pinned announcements:** Announcements with `pinned: true` are surfaced at the top of the list via the `pinned_first` scope.

## Roles & Permissions

| Action | Standard | Coordinator | Admin |
| :--- | :---: | :---: | :---: |
| View published events | ✓ | ✓ | ✓ |
| RSVP to events | ✓ | ✓ | ✓ |
| Create/edit events | | ✓ | ✓ |
| Post announcements | | ✓ | ✓ |
| Manage all records | | | ✓ |

## Next Steps

- Implement controllers and views for Events, RSVPs, and Announcements
- Add Pundit or CanCanCan for role-based authorisation
- Add email notifications when announcements are posted (Action Mailer)
- Configure for production deployment (PostgreSQL, Active Storage)
