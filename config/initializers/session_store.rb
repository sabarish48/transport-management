# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_transport_session',
  :secret      => 'a29b843b7bdedabe158da61d2bb2a3d813a85c6cbc1e98eb0bf5f667a2b5e0346f7fe9d0174bbe9c855b6bf2f55aecdbbef0595451d583f32ea8564d18927d15'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
