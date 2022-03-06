get "/feed" do
    @posts = Post.all

    erb :feed
end