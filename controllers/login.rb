get "/" do
  redirect "/login" unless session[:logged_in]
  erb :feed
end

get "/login" do
<<<<<<< HEAD
  @user = User.new
  erb :login
end

post "/login" do
  @user = User.new
  @user.load(params)
  @error = nil

  if @user.exist?
    session[:logged_in] = true
    redirect "/feed"
  else
    @error = "The username or password that you entered is incorrect, please try again"
  end


  if @user.valid?
    if @user.exist?
      session[:logged_in] = true
      redirect "/feed"
    else
      @error = "The username or password that you entered is incorrect, please try again"
    end
  else
    @error = "Please correct the information below"
  end


  erb :login
end

get "/logout" do
  session.clear
  erb :login
end
=======
    # Temporary, until login is implemented:
    session[:logged_in] = true
    session[:is_guest] = 0 # Not a guest
    session[:account_type] = 3 # Admin
    session[:userID] = 1
    session[:username] = "admin1"
    session[:universityID] = 1
    
    erb :login
end
>>>>>>> 4707b7108e0a35e5c62abfb82db3462f14dda066
