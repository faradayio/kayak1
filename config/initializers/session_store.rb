# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_wlpf1_session',
  :secret      => '795581cc6822844240058f0907381a350f0133979fff81a4c2b34f9635e8cddd28bd559f55fa79960c2cc13188df3eb49b2e800808617d6c5ab77da608e94da2'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
