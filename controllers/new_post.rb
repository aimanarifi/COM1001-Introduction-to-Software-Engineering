# Author: Alexander Johns

get "/new-post" do
    if request.cookies["is_logged_in"] == 1
        @post = Post.new
        erb :new_post
    else
        erb :login
    end
end

post "/new-post" do
    if request.cookies["is_logged_in"] == 1
        # Create new post, add parameters from form
        @post = Post.new
        @post.load(params)

        # If valid post, save changes to db, redirect to feed
        if @post.valid?
            @post.save_changes
            redirect "/"
        end

        erb :new_post
    else
        erb :login
    end
end
