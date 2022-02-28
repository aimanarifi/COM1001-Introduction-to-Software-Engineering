require "db/db"
require "sequel"
require "../models/user.rb"

DB = Sequel.sqlite("../db/production.sqlite3" , logger: Logger.new("db.log"))

get "/moderation-feed" do
    #Fetch the usertype from database (post table)
    user_id = #the mod id
    user_uni = #the mod university
    user_type = User.select(account_type).where(username: user_id)

    if user_type == 2
        #Fetch all the unmoderated posts that matches the mod's university
        @posts = Post.where(is_moderated: 0).where(university: user_uni)

    elsif user_type == 3
        #Fetch all unmoderated posts
        @posts = Post.where(is_moderated: 0)
    end

    erb: moderation-feed
end

get "/moderator-action" do
    id = params[post_id]
    @post = Post.[id]
    @user = User.where(username: @post.username)
    erb:moderation-action
end

post "/moderation-action/approve" do

    input = params["post_id"]
    DB[:posts].filter(post_id: input).update(is_moderated: 1)
    redirect "/moderation-feed"

end

post "/moderation-action/reject" do

    input = params["post_id"]
    DB[:posts].filter(post_id: input).update(is_moderated: 2)
    
    redirect "/moderation-feed"
    
end
