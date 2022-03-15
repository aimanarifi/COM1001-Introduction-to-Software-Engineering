get "/profile" do
    redirect "/login" unless session[:logged_in] == 1

    @user = DB[:users].where(userID: session[:userID]).first
    @posts = DB[:posts].where(userID: session[:userID])

    erb :user_profile
end
