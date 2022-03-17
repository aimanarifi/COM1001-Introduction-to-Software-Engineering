require_relative "../spec_helper"

describe "the login page" do
    context "when logging in," do
        it "can login as an admin" do
            log_in_admin
            expect(page).to have_content "Feed"
        end
    
        it "can login as a moderator" do
            log_in_moderator
            expect(page).to have_content "Feed"
        end
    
        it "can login as a viewer" do
            log_in_viewer
            expect(page).to have_content "Feed"
        end
    
        it "can login as a reporter" do
            log_in_reporter
            expect(page).to have_content "New Post"
        end
    end

    context "when accessing the page," do
        it "is accessible when logged out" do
            visit "/logout"
            expect(page).to have_content "Welcome To ACME"
        end

        it "is not accessible when logged in" do
            log_in_admin
            visit "/login"
            expect(page).to have_content "Feed"
        end
    end
end