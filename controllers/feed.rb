get "/" do
    # Temporary, until login is implemented:
    session[:logged_in] = true
    session[:is_guest] = 0 # Not a guest
    session[:account_type] = 3 # Admin
    session[:user_id] = 1
    session[:username] = "admin1"
    session[:universityID] = 1

    redirect "/login" unless session[:logged_in]

    @posts = Post.all

    # Posts added to DB in chronological order
    # Reverse the list of posts to have newest-first
    @posts = @posts.reverse

    erb :feed
end
