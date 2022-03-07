# Author: Alexander Johns

get "/" do
    # Temporary, until login is implemented:
    session[:logged_in] = true

    redirect "/login" unless session[:logged_in]

    @posts = Post.all

    # Posts added to DB in chronological order
    # Reverse the list of posts to have newest-first
    @posts = @posts.reverse

    erb :feed
end
