#Author: Muhammad Kamaludin
#TODO: validation and sanisation in this file and the erb(s)
#TODO: Styling

get "/moderationfeed" do
    #This route fetch the account_type from database to determine whether he/she is a mod or admin
    #and display the unmoderated content to them
    user_id = session[:userID]

    redirect "/login" unless session[:logged_in]

    @user = User[user_id]

=begin This is for feed filter 
    if params["filter"].nil?
        @filter = "All"
    else
        @filter = params["filter"]
    end
=end    

    unless @user.nil?
        #Display all unmoderated post to admin, while for moderator, display posts that matches their university only
        if @user[:account_type] == 2

            @user_type_query = "Moderator"
            @posts = Post.where(universityID: @user[:universityID]).where(is_moderated: 0)

        elsif @user[:account_type] == 3

            @user_type_query = "Administrator"
            @posts = Post.where(is_moderated: 0).all
            
        end

    end

    erb :moderationfeed
end

get "/moderationaction" do

    id = params["postID"]
    @post = Post[id]
    @post_user = User[@post[:userID]]

    erb :moderationaction
end

post "/approve" do

    id = params["postID"]

    @post = Post[id]
    @post.publish(params)

    if @post.valid?
        redirect "/moderationfeed"
    end

    erb :moderationaction

end

post "/reject" do

    id = params["postID"]

    route = "/delete_post?postID=" + id
    redirect route

end