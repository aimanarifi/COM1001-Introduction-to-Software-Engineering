require_relative "../spec_helper"

describe "the new post page" do
    # TODO: check if it's accessible from other pages

    it "will not create a post with no details" do
        visit "/new-post"
        click_button "Submit"
        expect(page).to have_content "Please fix the errors below"
    end

    it "will not create a post with missing details" do
        visit "/new-post"
        add_invalid_test_post
        expect(page).to have_content "cannot be empty"
    end

    it "creates a post when all details are entered" do
        visit "/new-post"
        add_test_post
        expect(page).to have_content "feed"
        clear_database
    end
end
