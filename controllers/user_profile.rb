get "/profile" do
    redirect "/login" unless session[:logged_in] == 1

    @user = User.where(userID: session[:userID]).first
    @posts = Post.where(userID: session[:userID]).order(:date_posted).reverse

    erb :user_profile
end
