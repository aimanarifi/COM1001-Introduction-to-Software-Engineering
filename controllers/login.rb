# Author: Habil Bin Abdul Rahim Khan Suratee 
# Updated By: Alexander Johns

get "/login" do
  redirect "/" if session[:logged_in] == 1

  @user = User.new
  erb :login
end

post "/login" do
  redirect "/" if session[:logged_in] == 1
  
  @user = User.new
  @user.login(params)
  @error = nil

  if @user.exist? && @user.valid?
    @logged_in_user = User.where(username: params.fetch("username","")).first || 
    @logged_in_user = User.where(email: params.fetch("username","")).first

    
    session[:logged_in] = 1
    session[:is_guest] = 0
    session[:account_type] = @logged_in_user.account_type
    session[:userID] = @logged_in_user.userID
    session[:username] = @logged_in_user.username
    session[:universityID] = @logged_in_user.universityID

    redirect "/"
  else
    @error = "The username or password that you entered is incorrect, please try again"
  end

  erb :login
end

