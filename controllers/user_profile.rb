get "/profile" do
    redirect "/login" unless session[:logged_in] == 1

    @user = User[session[:userID]]
    @posts = Post.where(userID: session[:userID]).order(:date_posted).reverse

    erb :user_profile
end
