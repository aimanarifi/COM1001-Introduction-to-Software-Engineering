#Author: Muhammad Kamaludin

get "/delete-post" do
    redirect "/login" unless session[:logged_in] == 1

    id = params["postID"]
    @post = Post[id]
    @report_reason = DB[:report_reasons] 

    erb :delete_post
end

post "/delete-post" do
    id = params["postID"]
    @post = Post[id]
    @post.update(is_moderated: 2)

    #insert new entry to tht reported_posts table here

    redirect "/post-moderation-feed"
    erb :delete_post
end