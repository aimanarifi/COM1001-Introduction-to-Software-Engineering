# Author: Alexander Johns & Lexi Wheadon

get "/" do
    redirect "/login" unless session[:logged_in] == 1

    redirect "/new-post" if session[:is_guest] == 1 || session[:account_type] == 0

    @posts = Post.where(is_moderated: 1).order(:date_posted).reverse

    erb :feed
end
