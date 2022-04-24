# Author: Alexander Johns & Lexi Wheadon

get "/" do
    redirect "/login" unless session[:logged_in] == 1

    redirect "/new-post" if session[:is_guest] == 1 || session[:account_type] == 0

    if params["filter"].nil? || params["filter"] == ""
        @filter = nil
    else
        #filter params with have the string "<filtertype>,<post/tagID>,<tag/uniname>"
        @filter = params["filter"].split(",")
        @filter_type = @filter[0]
        @filter_id = @filter[1]
        @filter_name = @filter[2]    
    end

    @posts = Post.where(is_moderated: 1).order(:date_posted).reverse

    erb :feed
end
