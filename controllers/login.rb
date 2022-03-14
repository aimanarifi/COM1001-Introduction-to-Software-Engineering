get "/" do
  redirect "/login" unless session[:logged_in]
  erb :feed
end

get "/login" do
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
