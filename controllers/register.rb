#Author: Raymon Narwal
#Todo: Write check for uni email + check for password len>7
get "/register" do
    redirect "/" if session[:logged_in] == 1

    id = params["userID"]
    @user = User.new[id]

    erb :register
end

post "/register" do
    redirect "/" if session[:logged_in] == 1

    @user = User.new(username: params["username"], password: params["password"], email: params["email"], first_name: params["first_name"])
    @user.save
    
    if @user.valid?
        redirect "/"
    else
        @error = "not working"
    end

    erb :register
end