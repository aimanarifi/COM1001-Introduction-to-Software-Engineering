# Author: Alexander Johns

require_relative "../spec_helper"

describe "the user profile page" do
    context "when accessing the page," do
        it "is not accessible when logged out" do
            visit "/logout"
            visit "/profile"
            expect(page).to have_content "Log In"
        end
        
        it "is accessible from the feed page" do
            log_in_viewer
            visit "/"
            click_link "Profile"
            expect(page).to have_content "Profile"
        end
    end

    it "will display the user's details" do
        log_in_viewer
        visit "/profile"
        expect(page).to have_content "Name: "
        expect(page).to have_content "Email: "
        expect(page).to have_content "Account Type: "
        expect(page).to have_content "University: "
    end

    it "will be empty when user hasn't created any posts" do
        log_in_viewer
        visit "/profile"
        expect(page).to have_content "No posts were found."
    end

    it "will display posts by this user" do
        log_in_viewer
        visit "/new-post"
        add_test_post
        Post.last.update(is_moderated: 1)

        visit "/profile"
        expect(page).to have_content "Tags:"

        clear_database
    end
end
