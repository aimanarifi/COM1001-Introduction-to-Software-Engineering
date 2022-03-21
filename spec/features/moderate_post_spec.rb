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

            visit "/post-moderation-feed"
            click_link "Moderate Post"
            expect(page).to have_content "Manage Post"
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

            visit "/post-moderation-feed"
            click_link "Moderate Post"
            click_link_or_button "approve"

            test_post = Post.last
            expect(test_post.is_moderated).to eq(1)
            clear_database

        end

    end

    context "when the reject button is clicked" do

        it "redirect to the delete post page" do
            log_in_admin
            add_test_post
            Post.last.update(is_moderated: 0)

            visit "/post-moderation-feed"
            click_link "Moderate Post"
            click_link_or_button "reject"
            expect(page).to have_content "Delete Post"
            clear_database
        end

        it "update the is_moderated attribute to 2" do

            log_in_admin
            add_test_post
            Post.last.update(is_moderated: 0)

            visit "/post-moderation-feed"
            click_link "Moderate Post"

            DB.run "INSERT INTO report_reasons VALUES(1,\"Report1\");"

            click_link_or_button "reject"

            choose "reason1"

            click_link_or_button "Delete post"
            
            test_post = Post.last
            expect(test_post.is_moderated).to eq(2)
            clear_database

        end

    end

end
