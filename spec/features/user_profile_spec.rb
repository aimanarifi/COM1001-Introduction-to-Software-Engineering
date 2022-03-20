# Author: Alexander Johns

require_relative "../spec_helper"

describe "the new post page" do
    context "when accessing the page," do
        it "is not accessible when logged out" do
            visit "/logout"
            visit "/profile"
            expect(page).to have_content "Welcome To ACME"
        end
        
        it "is accessible from the feed page" do
            log_in_viewer
            visit "/"
            click_link "Profile"
            expect(page).to have_content "Profile"
        end
    end
end
