#Author: Muhammad Kamaludin
require_relative "../spec_helper"


describe "General/ Admin's moderation feed: " do

    context "when unmoderated post is added into the database," do

        it "display the post in the mod's feed" do

            log_in_admin
            add_test_post
            Post.last.update(is_moderated: 0)

            visit "/moderationfeed"
            expect(page).to have_content "This is a post!"
            expect(page).to have_content "This is the content of my post!"
            clear_database

        end

    end

    context "When moderated post is added into the database" do

        it "doesn't display it in the feed. (Case 1: is_moderated == 1)" do

            log_in_admin
            add_test_post
            Post.last.update(is_moderated: 1)
                
            visit "/moderationfeed"
            expect(page).not_to have_content "This is a post!"
            expect(page).not_to have_content "This is the content of my post!"
            clear_database

        end

        it "doesn't display it in the feed. (Case 2: is_moderated == 2)" do

            log_in_admin

            add_test_post
            Post.last.update(is_moderated: 2)
                
            visit "/moderationfeed"
            #expect the feed to not have the post title and message
            expect(page).not_to have_content "This is a post!"
            expect(page).not_to have_content "This is the content of my post!"
            clear_database

        end

    end
    
end

=begin   This testing need something that can modify session, prolly login system

describe "Mod's moderation feed: " do

    context "when unmoderated post from mod's university is added into the database" do

        it " display the posts in the feed " do

            log_in_admin


            add_test_post
            test_post = Post.last
            test_post.update(is_moderated: 0)

            uni_name = DB[:universities].where(universityID: test_post.universityID)[:university_name]
            change_acc_type_mod
            visit "/moderationfeed"
            expect(page).to have_content uni_name
            clear_database

        end
    end

    context "when unmoderated post from other university is added into the databse" do

        it " does not display the post" do

            log_in_admin
            

            add_test_post
            test_post = Post.last
            test_post.update(is_moderated: 0)
            test_post.update(universityID: test_post.universityID + 1 )

            uni_name = DB[:universities].where(universityID: test_post.universityID)[:university_name]
            change_acc_type_mod
            visit "/moderationfeed"
            expect(page).not_to have_content uni_name
            clear_database
                
        end
    end
end

=end
