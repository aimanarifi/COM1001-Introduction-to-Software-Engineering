# Author: Alexander Johns

get "/new-post" do
    redirect "/login" unless session[:logged_in]

    @post = Post.new
    erb :new_post
end

post "/new-post" do
    redirect "/login" unless session[:logged_in]

    # Create new post, add parameters from form
    @post = Post.new

    # Add session cookies to params hash
    params[:username] = session[:username]
    params[:account_type] = session[:account_type]

    @post.load(params)

    # If valid post, save changes to db, redirect to feed
    if @post.valid?
        @post.save_changes
        redirect "/"
    end

    erb :new_post
end
