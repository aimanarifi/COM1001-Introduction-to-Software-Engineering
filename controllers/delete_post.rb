get "/delete_post" do
    id = params["postID"]
    @post = Post[id]
    @report_reason = DB[:report_reasons] 

    erb :delete_post
end

post "/delete_post" do

    id = params["postID"]
    @post = Post[id]
    @post.update(is_moderated: 2)

    #insert new entry to tht reported_posts table here

    redirect "/moderationfeed"
    erb :delete_post
end