# Author: Alexander Johns

require_relative "../spec_helper"

describe "the feed page" do
    it "is accessible from the new post page" do
        log_in_viewer
        visit "/new-post"
        click_link "Cancel"
        expect(page).to have_content "Feed"
    end

    it "will be empty when no posts exist" do
        log_in_viewer
        visit "/"
        expect(page).to have_content "No posts were found."
    end

    it "will display new posts" do
        log_in_admin
        visit "/new-post"
        add_test_post

        expect(page).to have_content "By admin"
        clear_database
    end
end
