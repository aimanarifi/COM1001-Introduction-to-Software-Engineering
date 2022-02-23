# Create a new post

get "/new-post" do
    @post = Post.new
    erb :new_post
end

post "/new-post" do
    # Create new post, add parameters
    @post = Post.new
    @post.load(params)

    # If object is valid, save changes to database, redirect to home
    if @player.valid?
        @player.save_changes
        redirect "/"
    end

    erb :new_post
end
