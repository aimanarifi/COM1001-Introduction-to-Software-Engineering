# Author: Alexander Johns

require_relative "../spec_helper"

describe "the new post page" do
    it "is accessible from the feed" do
        log_in_viewer
        visit "/"
        click_link "Create Post"
        expect(page).to have_content "New Post"
    end

    it "will not create a post with no details" do
        log_in_viewer
        visit "/new-post"
        click_button "Submit"
        expect(page).to have_content "Title cannot be empty"
    end

    it "will not create a post with missing details" do
        log_in_viewer
        visit "/new-post"
        add_invalid_test_post
        expect(page).to have_content "cannot be empty"
    end

    it "will not create a post with a title over 100 characters" do
        log_in_viewer
        visit "/new-post"
        add_post_title_too_long
        expect(page).to have_content "cannot be more than 100 characters"
    end

    it "will not create a post with a message over 1000 characters" do
        log_in_viewer
        visit "/new-post"
        add_post_message_too_long
        expect(page).to have_content "cannot be more than 1000 characters"
    end

    it "creates a post when all details are entered" do
        log_in_viewer
        visit "/new-post"
        add_test_post
        expect(page).to have_content "Feed"
        clear_database
    end
end
