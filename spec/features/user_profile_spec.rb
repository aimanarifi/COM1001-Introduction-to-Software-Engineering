# Author: Alexander Johns

require_relative "../spec_helper"

describe "the new post page" do
    before(:all) { log_in_viewer }

    it "is accessible from the feed page" do
        visit "/"
        click_link "Profile"
        expect(page).to have_content "Profile"
    end
end
