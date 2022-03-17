#Author: Muhammad Kamaludin
require_relative "../spec_helper"

#TODO: Add test for post modification
#TODO: Add test for image deletion
#TODO: cleanup mess

describe "The moderation feed," do

    context "when the moderate button is clicked," do

        it "opens the moderation form" do

            log_in_admin
            add_test_post
            Post.last.update(is_moderated: 0)

            visit "/moderationfeed"
            click_link "Moderate post"
            expect(page).to have_content "Manage post"
            clear_database

        end

    end

end

describe "The individual post moderation page" do

    context "when the approve button is clicked" do

        it "update the is_moderated attribute to 1" do

            log_in_admin
            add_test_post
            Post.last.update(is_moderated: 0)

            visit "/moderationfeed"
            click_link "Moderate post"
            click_link_or_button "approvebutton"

            test_post = Post.last
            expect(test_post.is_moderated).to eq(1)
            clear_database

        end

        it "the post does not appear in the moderation feed" do

            log_in_admin
            add_test_post
            Post.last.update(is_moderated: 0)

            visit "/moderationfeed"
            click_link "Moderate post"
            click_link_or_button "approvebutton"
            expect(page).not_to have_content "This is a post!"
            expect(page).not_to have_content "This is the content of my post!"
            clear_database
    
        end

    end
    context "when the reject button is clicked" do

        it "redirect to the delete post page" do
            log_in_admin
            add_test_post
            Post.last.update(is_moderated: 0)

            visit "/moderationfeed"
            click_link "Moderate post"
            click_link_or_button "rejectbutton"
            expect(page).to have_content "Delete post"
            clear_database
        end

        it "update the is_moderated attribute to 2" do

            log_in_admin
            add_test_post
            Post.last.update(is_moderated: 0)

            visit "/moderationfeed"
            click_link "Moderate post"

            DB.run "INSERT INTO report_reasons VALUES(1,\"Report1\");"

            click_link_or_button "rejectbutton"

            choose "reason1"

            click_link_or_button "Delete post"
            
            test_post = Post.last
            expect(test_post.is_moderated).to eq(2)
            clear_database

        end

        it "the post does not appear in the moderation feed" do

            log_in_admin
            add_test_post
            Post.last.update(is_moderated: 0)

            visit "/moderationfeed"
            click_link "Moderate post"

            DB.run "INSERT INTO report_reasons VALUES(1,\"Report1\");"

            click_link_or_button "rejectbutton"

            choose "reason1"
            click_link_or_button "Delete post"
            expect(page).not_to have_content "This is a post!"
            expect(page).not_to have_content "This is the content of my post!"
            clear_database

        end

    end

end




