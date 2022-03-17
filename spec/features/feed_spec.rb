require_relative "../spec_helper"

describe "the feed page" do
    before(:all) { log_in_viewer }

    it "is accessible from the new post page" do
        visit "/new-post"
        click_link "Cancel"
        expect(page).to have_content "Feed"
    end
end
