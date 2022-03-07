# Author: Alexander Johns

get "/" do
    # Temporary, for testing:
    response.set_cookie("is_logged_in", 1)

    # If logged in, go to feed
    # Else, go to log in 
    if request.cookies["is_logged_in"].to_i == 1
        @posts = Post.all

        # Posts added to DB in chronological order
        # Reverse the list of posts to have newest-first
        @posts = @posts.reverse

        erb :feed
    else
        erb :login
    end
end
