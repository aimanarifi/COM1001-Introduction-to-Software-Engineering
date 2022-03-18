#Author: Muhammad Kamaludin
get "/user-moderation-feed" do 

    user_id = session[:userID]
    redirect "/login" unless session[:logged_in]

    unless params["filter"].nil?
        #filter params with have the string "<filtertype>,<post/tagID>,<tag/uniname>"
        @filter = params["filter"].split(",")
        @filter_type = @filter[0]
        @filter_id = @filter[1]
        @filter_name = @filter[2]
    else
        @filter = nil
    end

    @user = User[user_id]  

    unless @user.nil?
        #Only admin can moderate accounts
        if @user[:account_type] == 3

            @user_type_query = "Moderator"
            @account = User.where(account_type: 1).reverse
            @account = @account.where(universityID: @filter) if !@filter.nil? && @filter_type == "uni"
        
        else
            redirect "/"    
        end

    else
        redirect "/"
    end



    erb :account_moderation_feed
end

get "/restore-account" do

    User[params["userID"]].update(is_suspended: 0)
    

    DB[:deleted_users].where(userID: params["userID"]).delete

    redirect "/user-moderation-feed"

end