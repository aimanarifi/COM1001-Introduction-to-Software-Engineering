#Author: Raymon Narwal
get "/register" do
    redirect "/" if session[:logged_in] == 1

    id = params["userID"]
    @user = User.new[id]

    erb :register
    "register page"
end

post "/register" do
    redirect "/" if session[:logged_in] == 1

    @user = User.new(userID: params["userID"], username: params["username"], password: params["password"], email: params["email"], first_name: params["first_name"])
    @user.save
    
    if @user.valid?
        redirect "/"
    else
        @error = "not working"
    end

    erb :register
end