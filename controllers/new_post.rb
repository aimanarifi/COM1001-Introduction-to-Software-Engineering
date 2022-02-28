# Create a new post

get "/new-post" do
    @post = Post.new
    erb :new_post
end

post "/new-post" do
    # Create new post, add parameters from form
    @post = Post.new
    @post.load(params)

    # If object is valid, save changes to database, redirect to home
    if @post.valid?
        @post.save_changes
        redirect "/feed"
    end

    erb :new_post
end
