# Sets up the sqlite3 database file

# Gems
require "logger"
require "sequel"

# What mode are we in?
type = ENV.fetch("APP_ENV", "production")

# Find the path to the database file
db_path = File.dirname(__FILE__)
db = "#{db_path}/#{type}.sqlite3"

# Find the path to the logger
log_path = "#{File.dirname(__FILE__)}/../log/"
log = "#{log_path}/#{type}.log"

# Create log directory if it doesn't exist
Dir.mkdir(log_path) unless File.exist?(log_path)

# Set up the Sequel databse instance
DB = Sequel.sqlite(db, logger: Logger.new(log))