get "/" do
    redirect "/login" unless session[:logged_in] == 1

    @posts = Post.all

    # Posts added to DB in chronological order
    # Reverse the list of posts to have newest-first
    @posts = @posts.reverse

    erb :feed
end
