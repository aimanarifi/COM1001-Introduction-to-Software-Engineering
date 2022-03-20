# Author: Alexander Johns
# Updated: Muhammad Kamaludin 

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

# Login methods
def log_in_admin
    visit "/logout"
    fill_in "username", with: "admin"
    fill_in "password", with: "admin"
    click_button "Submit"
end

def log_in_moderator
    visit "/logout"
    fill_in "username", with: "moderator"
    fill_in "password", with: "moderator"
    click_button "Submit"
end

def log_in_viewer
    visit "/logout"
    fill_in "username", with: "viewer1"
    fill_in "password", with: "viewer1"
    click_button "Submit"
end

def log_in_reporter
    visit "/logout"
    fill_in "username", with: "reporter1"
    fill_in "password", with: "reporter1"
    click_button "Submit"
end

def log_in_incorrect_username
    visit "/logout"
    fill_in "username", with: "adm1n"
    fill_in "password", with: "admin"
    click_button "Submit"
end

def log_in_incorrect_password
    visit "/logout"
    fill_in "username", with: "admin"
    fill_in "password", with: "adm1n"
    click_button "Submit"
end

# Creating a post methods
def add_test_post
    visit "/new-post"
    fill_in "title", with: "This is a post!"
    fill_in "message", with: "This is the content of my post!"
    fill_in "tags", with: "Tag, another tag, yet another tag"
    fill_in "image_link", with: "https://imgur.com/gallery/lePaN"
    click_button "Submit"
end

def add_invalid_test_post
    visit "/new-post"
    fill_in "title", with: "This is a post!"
    click_button "Submit"
end

def add_post_title_too_long
    visit "/new-post"
    fill_in "title", with: "HBftkbhYbVjJzPWzwMYGfaBpXtXcXaNRtSzpNuNcpXqsguRgnDRSeNjRVnjDUVHvnNktZcvBOBDPrZYJHRmxmtjtaOZBxVchCgJjA"
    click_button "Submit"
end

def add_post_message_too_long
    visit "/new-post"
    fill_in "message", with: "QXTjNWOAveHkaOBSkxwnksEWrWoXASNqKYDOVFytZywoyWhhFhDnaJWDgQOuFMWKgHBCtWGkPcpufARFBMjuOkCVNTAMMdhrNpxXjpaKSDwegNYEboyepajTUZhhhFHsEZFFzccsEuOwRkDHbkCnauhkJnrXKBPCJcFBPvCJkyPdNCFWpTcKTHstPDyGyQouSyEFzYBxNQUFFatFqdZVgJkzUoQjGRbTCbYvyWYyNePVBHUZaFhvGAYPJhHmHOaPOVWKYWmOJkxrYvPUTduAvjxWgNnZeWoBaTRXngtEZUByGyGJfZRZOurbNSFcCORwCbPRyjsCuSBSdbaesjOwGDOAhqUnOgMvPogcFWOGxYtZhTnXbDjkPjpmupkjxdTsJtaKoxKxGSyhbODRCbgZTQYwONWobWfnweVcxqCdyvKTMVPWsmFyDCjfEVdceMwHXDpTuEfuHJpjcdsrFOcqUzduvoaDJmvWwPpoFPKaOveqKJjScxFVkbZPpkSuQcqpPfJRduhDORrXhYsTOQauBaACCwMwvNqQGVNNxBJMSBRErGFstdvXkoYYavxEnmnDQVVtNURVgmPkVwhCAwavzuHNcEADwjqKttAEpJMnMpjxQQxhSsvjzDfVzqKVHtQoYXcHAaeeTeASQwcHRzNFqCdTAWvTYxeVYoHZfaqdtmHHryXJQneRffonppmdmDnXXAvHpYcZHazPcWAquHrgdtFFArjKzYBgCHSGGOJHQQZFAgqNzjQNEsKJPGyAXTdjushnxWRtPunNfYcrWjhRfJeyDSNrDQSRQfQNoEeoFVCTysoeDDUVsndbHGMETRjKUkyJbdqTUHTFncbKOYWPCPbQqWDrMmXETzFhAVZooUGskQytzNTQUjPSyodYuoFPmQdYFtaReQQdpfJseqSEEgrpNWmYrkCdeMsWyoAJJHMnkQqkRvPmcVGRVwbgaUjpppygCoRAoYsWQdzyXyroZneGuAXGJmCKDdrjmxrbB"
    click_button "Submit"
end

# Clear the database
def clear_database
    DB.from("post_tags").delete
    DB.from("posts").delete
    DB.from("report_reasons").delete
end

# Ensure we always start from a clear database
clear_database
