get "/login" do
  @user = User.new
  erb :login
end

post "/login" do
  @user = User.new
  @user.login(params)
  @error = nil

  if @user.exist? && @user.valid?
    session[:logged_in] = 1
    session[:is_guest] = 0
    session[:account_type] = @user.account_type
    session[:userID] = @user.userID
    session[:username] = @user.username
    session[:universityID] = @user.universityID

    redirect "/"
  else
    @error = "The username or password that you entered is incorrect, please try again"
  end

  erb :login
end

get "/logout" do
  session.clear
  erb :login
end
