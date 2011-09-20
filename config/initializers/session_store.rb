# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_capsmi_session',
  :secret      => '1cfca7738600b366cabfd5be4dcb934f698e92cbf743da57bb3e1a9c9ac7ad9298adb88a7e37523cb1931a841079e1c5735a4dabbd78e423e829519f3ab078e4'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
