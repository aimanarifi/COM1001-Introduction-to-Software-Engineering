# Author: Alexander Johns

require_relative "../spec_helper"

describe "the feed page" do
    it "allows you to bookmark an unbookmarked post" do
        log_in_admin
        visit "/new-post"
        add_test_post

        click_link_or_button "Bookmark Post"
        expect(page).to have_content "Unbookmark Post"

        clear_database
    end

    it "allows you to unbookmark a bookmarked post" do
        log_in_admin
        visit "/new-post"
        add_test_post

        click_link "Bookmark Post"
        click_link "Unbookmark Post"
        expect(page).to have_content "Bookmark Post"

        clear_database
    end
end

describe "the bookmarks page" do
    it "is accessible from the feed" do
        log_in_viewer
        visit "/"
        click_link "Bookmarks"
        expect(page).to have_content "'s Bookmarks"
    end

    it "will be empty when user hasn't bookmarked any posts" do
        log_in_viewer
        visit "/bookmarks"
        expect(page).to have_content "No posts were found."
    end

    it "allows you to view bookmarked posts" do
        log_in_admin
        visit "/new-post"
        add_test_post
        click_link "Bookmark Post"

        visit "/bookmarks"
        expect(page).to have_content "Unbookmark Post"

        clear_database
    end

    it "allows you to unbookmark a bookmarked post" do
        log_in_admin
        visit "/new-post"
        add_test_post
        click_link "Bookmark Post"

        visit "/bookmarks"
        click_link "Unbookmark Post"
        expect(page).to have_content "No posts were found."

        clear_database
    end
end