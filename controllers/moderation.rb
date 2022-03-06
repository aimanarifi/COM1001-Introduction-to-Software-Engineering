#Author: Muhammad Kamaludin
#TODO: validation and sanisation in this file and the erb(s)
#TODO: Styling

get "/moderationfeed" do
    #This route fetch the account_type from database to determine whether he/she is a mod or admin
    #and display the unmoderated content to them

    ####Instruction for manual testing####
    #navigate through db
    #Run sqlite3 test.sqlite3
    #Run .table to see tables available
    #Run .schema to see the columns of each table
    # To see contect of the tables: Run SELECT * FROM <table name>;
    # To Add new user manually in db: Run INSERT INTO users VALUES("<username>","<password>", "<email>", "<first_name>", "<last_name>", <account_type>, <is_suspended>, "<university>"); 
    # To Add new post manually in db: Run INSERT INTO posts VALUES(<post_id>, "<username>", "<title>", "<message>", "<university>", "<tags>", "<date_posted>", <is_moderated>, <is_image>, "<image_link>");
    #**just copy and paste the commands above to use it, change only the <> and what's in it. Don't change the any other symbols/punctuation mark
    #**is_moderated: 0 - unmoderated , 1 - approved, 2 - rejected

    user_id = "admin1" #<--- you change this to test your new entry to the db
    #user_id = request.cookies["user_id"] <--- dont change this, not tested yet

    @user_dataset = User.where(username: user_id)
    user = @user_dataset.first
    

    #Display all unmoderated post to admin, while for moderator, display posts that matches their university only
    if user.account_type == 2

        @user_type_query = "Moderator"
        @posts = Post.where(university: user.university).where(is_moderated: 0)

    elsif user.account_type == 3

        @user_type_query = "Administrator"
        @posts = Post.where(is_moderated: 0)

    else

        #redirect "/feed"
        
    end

    erb :moderationfeed
end

get "/moderationaction" do

    @id = params["post_id"]
    @post = Post[@id]

    erb :moderationaction
end

post "/approve" do

    input = params["post_id"]
    Post.where(post_id: input).update(is_moderated: 1)
    redirect "/moderationfeed"

end

post "/reject" do

    input = params["post_id"]
    Post.where(post_id: input).update(is_moderated: 2)
    redirect "/moderationfeed"
    
end
