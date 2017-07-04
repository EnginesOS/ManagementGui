# Engines Management GUI

Rails 5 application for managing Engines systems.

### config
Redis for ActionCable
Persistent directory 'public/system'

ENV['BUG_REPORTS_SERVER'] # e.g. 'http://myhost.example.com:3999'
ENV['SYSTEM_API_URL'] # e.g. 'http://myhost.example.com:2380'
ENV['ACTIONCABLE_URL'] # e.g. 'redis://myhost.example.com:6379/1'
ENV['ACTION_CABLE_ALLOWED_REQUEST_ORIGINS']
ENV['USER_TIMEOUT_MINUTES'] # default is 30

ENV['ENABLE_MULTIPLE_SYSTEMS'] # default is false
ENV['ENABLE_MULTIPLE_CLOUDS'] # default is false
ENV['ENABLE_MULTIPLE_LIBRARIES'] # default is false
ENV['ENABLE_USER_PORTAL'] # default is false -- User portal feature is partially implemented
ENV['ENABLE_MULTIPLE_USERS'] # default is false -- Doesn't do anything. Multi user feature is not implemented yet

ENV["SECRET_KEY_BASE"] # e.g. 930954043830845304580438534080438
ENV["REDIS_URL"] # e.g. 'redis://localhost:6379/1'

### sign in
Username: admin
Password: password
