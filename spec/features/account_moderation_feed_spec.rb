#Author: Muhammad Kamaludin

require_relative "../spec_helper"

describe "Account Moderation Feed" do
    context "when opened" do 
        
        it "display the page properly" do
            log_in_admin
            visit "/user-moderation-feed"
            expect(page).to have_content "Moderate Accounts"
        end

        it "display all accounts" do
            log_in_admin
            DB.run "INSERT INTO users VALUES(100,\"testuser\",\"testuser\",\"testuser@gmail.com\",\"firsname\",\"lastname\",0,1,100);"
            visit "/user-moderation-feed"
            expect(page).to have_content "testuser"
            User.last.delete
            clear_database
        end
    end

    context "when non suspended user is added into database" do
        it "admin can suspend it" do
            log_in_admin
            DB.run "INSERT INTO users VALUES(100,\"testuser\",\"testuser\",\"testuser@gmail.com\",\"firsname\",\"lastname\",0,1,100);"
            visit "/user-moderation-feed"
            expect(page).to have_link "Delete Account"
            User.last.delete
            clear_database
        end
    end

    context "when suspended user is added into database" do
        it "admin can restore it" do
            log_in_admin
            DB.run "INSERT INTO users VALUES(100,\"testuser\",\"testuser\",\"testuser@gmail.com\",\"firsname\",\"lastname\",0,1,100);"
            User[100].update(is_suspended: 1)
            visit "/user-moderation-feed"
            expect(page).to have_link "Restore Account"
            User.last.delete
            clear_database
        end
    end
=begin
    context "when Delete Account button is clicked" do
        it "redirect to delete account page" do
            log_in_admin
            DB.run "INSERT INTO users VALUES(100,\"testuser\",\"testuser\",\"testuser@gmail.com\",\"firsname\",\"lastname\",0,1,100);"
            visit "/user-moderation-feed"
            find("Delete Account", count: 3 ).click
            expect(page).to have_content "Delete Account"
            User.last.delete
            clear_database
        end

        it "is_suspended changes to 1" do
            log_in_admin
            DB.run "INSERT INTO users VALUES(100,\"testuser\",\"testuser\",\"testuser@gmail.com\",\"firsname\",\"lastname\",0,1,100);"
            visit "/user-moderation-feed"

            DB.run "INSERT INTO report_reasons VALUES(1,\"Report1\");"
            click_link "Delete Account"

            choose "reason1"

            click_link_or_button "Delete user"
            expect(User[100].is_suspended).to eq(1)
            User.last.delete
            clear_database
        end
    end


    context "when Restore Account button is clicked" do
        it "is_suspended changes to 0" do
            log_in_admin
            DB.run "INSERT INTO users VALUES(100,\"testuser\",\"testuser\",\"testuser@gmail.com\",\"firsname\",\"lastname\",1,1,100);"
            visit "/user-moderation-feed"
            click_link "Restore Account"
            expect(User[100].is_suspended).to eq(0)
            User.last.delete
            clear_database
        end
    end
=end
end