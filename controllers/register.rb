#Author: Raymon Narwal
#Todo: Write check for uni email + check for password len>7
get "/register" do
    redirect "/" if session[:logged_in] == 1

    @user = User.new

    erb :register
end

post "/register" do
    redirect "/" if session[:logged_in] == 1

    params[:is_suspended] = 0
    params[:account_type] = 1

    @user = User.new

    @user.load(params)
    
    if @user.register_validate
        @user.save_changes
        redirect "/"
    end

    erb :register
end