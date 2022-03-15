get "/" do
    redirect "/login" unless session[:logged_in] == 1

    @posts = Post.where(is_moderated: 1).reverse

    erb :feed
end
