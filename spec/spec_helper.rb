# Configure coverage logging
require "simplecov"
SimpleCov.start do
    add_filter "/spec/"
end
SimpleCov.coverage_dir "coverage"

# Use the test database
ENV["APP_ENV"] = "test"

# Load the Sinatra app
require_relative "../app"

# Configure Capybara
require "capybara/rspec"
Capybara.app = Sinatra::Application

# Configure RSpec
def app
    Sinatra::Application
end
RSpec.configure do |config|
    config.include Capybara::DSL
    config.include Rack::Test::Methods
end


# Methods for testing
# Add a valid test post
def add_test_post
    visit "/new-post"
    fill_in "username", with: "testuser100"
    fill_in "title", with: "This is a post!"
    fill_in "message", with: "This is the content of my post!"
    fill_in "university", with: "University Of Sheffield"
    fill_in "tags", with: "Tag, another tag, yet another tag"
    fill_in "image_link", with: "https://imgur.com/gallery/lePaN"
    click_button "Submit"
end

# Add a test post with missing database
def add_invalid_test_post
    visit "/new-post"
    fill_in "title", with: "This is a post!"
    click_button "Submit"
end

# Clear the database
def clear_database
    DB.from("posts").delete
end


# Ensure we always start from a clear database
clear_database
