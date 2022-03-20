# Author: Alexander Johns

get "/guest" do
    session[:logged_in] = 1
    session[:is_guest] = 1
    
    redirect "/"
end