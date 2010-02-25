# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_SoccerSchedule_session',
  :secret      => 'd9a138bf8cbb555d36bc6f75f4c2717c2ef6e0ec9ffa0a3079fdb9ad43949034389af17208931155b364ad4b56a6ec6e50f3561bd57313addf8cc9c7ce0aaaa2'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
