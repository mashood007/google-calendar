# Google Calendar Integration with Rails 7

This project demonstrates how to integrate Google Calendar with a Ruby on Rails 7 application. The app lists Google Calendar events on a web interface, classified by calendar names.
Events are imported and saved to the database when an account is first connected, and subsequent changes (create, update, delete) are automatically synced with the database.

# Features
 - Google Authentication using OAuth2.
 - List of Google Calendar Events: Displays events classified by calendar names.
 - Automatic Sync: After the initial connection, the app automatically syncs new, updated, or deleted events from Google Calendar.
 - Live Sync: Uses Google Calendar API webhooks for real-time updates.


# Tech Stack
- Ruby on Rails 7
 - PostgreSQL
 - RSpec
 - OmniAuth
