# Create a new post

get "/new-post" do
    @post = Post.new
    erb :new_post
end

post "/new-post" do
    # Create new post, add parameters
    @post = Post.new
    @post.load(params)

    # Check if player object is valid, save changes, redirect

    erb :new_post
end
