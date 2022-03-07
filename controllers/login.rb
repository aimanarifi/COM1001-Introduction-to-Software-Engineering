get "/login" do
    session[:logged_in] = true
    
    erb :login
end