get "/login" do
    # Temporary, until login is implemented:
    session[:logged_in] = true
    session[:is_guest] = 0 # Not a guest
    session[:account_type] = 3 # Admin
    session[:userID] = 1
    session[:username] = "admin1"
    session[:universityID] = 1
    
    erb :login_page
end