# Author: Alexander Johns

get "/bookmarks" do
    redirect "/login" unless session[:logged_in] == 1
    redirect "/" if session[:is_guest] == 1

    @user = User[session[:userID]]

    # Get bookmarked posts for this user
    @postbookmarks = PostBookmark.where(userID: @user.userID).order(:date_bookmarked).reverse
    @posts = []
    @postbookmarks.each do |post|
        @posts.push(Post[post.postID])
    end

    erb :bookmarked_posts
end

get "/bookmark-post" do
    id = params["postID"]
    
    # Create new post bookmark
    @post_bookmark = PostBookmark.new
    params["userID"] = session[:userID]

    @post_bookmark.load(params)
    @post_bookmark.save_changes

    redirect "/"
end

get "/unbookmark-post" do
    id = params["postID"]

    # Delete bookmark
    DB[:post_bookmarks].filter(:postID => id).delete

    redirect params["source"]
end