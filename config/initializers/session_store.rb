# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_calendar_session',
  :secret      => 'ceb5f73353e2e9c925ea60eda5811ec4ec5643e04c61292fc269f8f3d4f3529c50bcfa54e59787ea31f0053e662a71dc1db0c5c051f4b7a0bc513d39992ec049'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
