#Author: Muhammad Kamaludin

get "/delete-user" do 
    id = params["userID"]
    @user = User[id]

    erb :delete_user
end

post "/delete-user" do

    id = params["userID"]
    report_reason = params["report_reasonID"]
    @user = User[id]

    #update user table and add new row in deleted_users table
    @user.update(is_suspended: 1)
    DB[:deleted_users].insert(userID: id, date_deleted: Time.new.strftime("%Y-%m-%d %H:%M:%S").to_s)
    redirect "/moderation-feed/users"
    erb :delete_user
end