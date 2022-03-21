#Author: Muhammad Kamaludin

require_relative "../spec_helper"


describe "Admin's post moderation feed," do

    it "shows the \"moderate post|moderate account\" tab" do 
        log_in_admin
        visit "/post-moderation-feed"
        expect(page).to have_content "Moderate Posts | Moderate Accounts"
    end

    context "when unmoderated post is added into the database," do

        it " admin can moderate the post" do

            log_in_admin
            add_test_post
            Post.last.update(is_moderated: 0)

            visit "/post-moderation-feed"
            expect(page).to have_content "This is a post!"
            expect(page).to have_content "This is the content of my post!"
            expect(page).to have_content "Unmoderated"
            expect(page).to have_link "Moderate Post"
            clear_database

        end

    end

    context "when moderated post is added into the database," do

        it "if is_moderated = 1, admin can delete the post" do

            log_in_admin
            add_test_post
            Post.last.update(is_moderated: 1)

            visit "/post-moderation-feed"
            expect(page).to have_content "This is a post!"
            expect(page).to have_content "This is the content of my post!"
            expect(page).to have_content "Approved"
            expect(page).to have_link "Delete Post"
            clear_database

        end

        it "if is_moderated = 2, admin can restore the post" do

            log_in_admin
            add_test_post
            Post.last.update(is_moderated: 2)

            visit "/post-moderation-feed"
            expect(page).to have_content "This is a post!"
            expect(page).to have_content "This is the content of my post!"
            expect(page).to have_content "Rejected/Deleted"
            expect(page).to have_link "Restore Post"
            clear_database

        end

    end
    
end

describe "Mod's post moderation feed: " do

    it "doesn't show the \"moderate post|moderate account\" tab" do 
        log_in_moderator
        visit "/post-moderation-feed"
        expect(page).not_to have_content "Moderate Posts | Moderate Accounts"
    end

    context "when moderated post is added into the database," do

        it " (is_moderated = 1 )doesn't display the post" do

            log_in_moderator
            add_test_post
            Post.last.update(is_moderated: 1)

            visit "/post-moderation-feed"
            expect(page).not_to have_content "This is a post!"
            expect(page).not_to have_content "This is the content of my post!"
            clear_database

        end

        it " (is_moderated = 2 )doesn't display the post" do

            log_in_moderator
            add_test_post
            Post.last.update(is_moderated: 2)

            visit "/post-moderation-feed"
            expect(page).not_to have_content "This is a post!"
            expect(page).not_to have_content "This is the content of my post!"
            clear_database

        end
    end

    context "when unmoderated post from mod's university is added into the database" do

        it " display the posts in the feed " do

            log_in_moderator
            add_test_post
            test_post = Post.last
            test_post.update(is_moderated: 0)
            uni_name = University[test_post.universityID][:university_name]

            visit "/post-moderation-feed"
            expect(page).to have_content uni_name
            clear_database

        end
    end

    context "when unmoderated post from other university is added into the databse" do

        it " does not display the post" do

            log_in_moderator
            add_test_post
            test_post = Post.last
            test_post.update(is_moderated: 0)
            test_post.update(universityID: test_post.universityID + 1)

            uni_name = University[test_post.universityID][:university_name]
            visit "/post-moderation-feed"
            expect(page).not_to have_content uni_name
            clear_database
                
        end
    end
end


