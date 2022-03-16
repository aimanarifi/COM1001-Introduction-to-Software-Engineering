get "/guest" do
    # TODO - 
    # Set correct cookies for being a guest
    # Redirect to feed
    # Add checking on other pages for if user is a guest
    session[:logged_in] = 1
    session[:is_guest] = 1
    
    redirect "/"
end