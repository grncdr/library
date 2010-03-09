# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key    => '_library_session',
  :secret => 'e79067bd9d81e07bd486389a7d5286187414d023d617f5f2a5238abb3b6b1b6654b9f348d3533a53d086788c47698afade38dfb90b7ee6874e74cb860599efdc'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
