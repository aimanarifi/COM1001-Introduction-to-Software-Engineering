get "/logout" do
    session.clear
    
    redirect "/login"
end