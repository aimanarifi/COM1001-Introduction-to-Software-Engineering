# Gems 
require "require_all"
require "sinatra"

# So we can escape HTML special characters in the view
include ERB::Util

# Sessions
enable :sessions
set :session_secret, "$g]Rd2M/WbJ`~~<GZWdH@Fm'ESk2_gckCtLJJkySYG"

# App
require_rel "db/db", "models", "controllers"