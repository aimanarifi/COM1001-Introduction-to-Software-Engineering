#Author: Muhammad Kamaludin
#TODO: validation and sanisation in this file and the erb(s)
#TODO: Styling

get "/post-moderation-feed" do
    #This route fetch the account_type from database to determine whether he/she is a mod or admin
    #and display the unmoderated content to them
    user_id = session[:userID]
    redirect "/login" unless session[:logged_in]

    if params["filter"].nil? || params["filter"] == ""
        @filter = nil
    else
        #filter params with have the string "<filtertype>,<post/tagID>,<tag/uniname>"
        @filter = params["filter"].split(",")
        @filter_type = @filter[0]
        @filter_id = @filter[1]
        @filter_name = @filter[2]    
    end

    @user = User[user_id]

    unless @user.nil?
        #Display all unmoderated post to admin, while for moderator, display posts that matches their university only
        if @user[:account_type] == 2
            
            @user_type_query = "Moderator"
            @posts = Post.where(universityID: @user[:universityID]).where(is_moderated: 0)

        elsif @user[:account_type] == 3

            @user_type_query = "Administrator"
            @posts = Post
            
        else
            redirect "/"
        end
    end

    erb :post_moderation_feed
end

get "/moderate-post" do

    id = params["postID"]
    @post = Post[id]
    @post_tags = PostTag.where(postID: @post.postID)

    erb :moderate_post
end

post "/approve" do

    id = params["postID"]

    @post = Post[id]
    @post_tags = PostTag.where(postID: @post.postID)

    updated_tags = []
    @post_tags.each_with_index do |tag, i|
        tag_id = params["tagID#{i}"]
        unless tag_id.nil?
            tag_id = tag_id.to_i
            updated_tags.push(tag_id)
        end
    end

    params["tags"] = updated_tags

    @post.publish(params)

    if @post.valid?
        @post.save_changes
        redirect "/post-moderation-feed"
    end

    erb :moderate_post

end

post "/reject" do

    id = params["postID"]

    route = "/delete-post?postID=" + id
    redirect route

end


get "/restore-post" do

    Post[params["postID"]].update(is_moderated: 0)

    # Delete the row in deleted_posts table DB[:deleted_posts].where(userID: params["userID"]).delete

    redirect "/post-moderation-feed"

end

